package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IProvider;
	import ee.gunk.IScope;
	import ee.gunk.Scopes;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.binder.IAnnotatedBindingBuilder;
	import ee.gunk.binder.ILinkedBindingBuilder;
	import ee.gunk.binder.IScopedBindingBuilder;
	import ee.gunk.metadata.AnnotationMetadata;
	import ee.gunk.metadata.ClassMetadataUtils;
	import ee.gunk.util.ClassUtil;
	import ee.gunk.util.DictionaryMap;
	import ee.gunk.util.IMap;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @private
	 */
	internal class BindingBuilder implements IAnnotatedBindingBuilder
	{
		private var _bindings:Vector.<IBinding>;
		private var _dependencyInjector:IDependencyInjector;
		private var _annotationRegistry:IAnnotationRegistry;
		
		private var _implementedByCache:IMap;
		private var _providedByCache:IMap;
		private var _singletonCache:IMap;
		
		private var _position:uint;
		private var _binding:IBinding;
		
		public function BindingBuilder(bindings:Vector.<IBinding>, dependencyInjector:IDependencyInjector, annotationRegistry:IAnnotationRegistry, type:Class)
		{
			_bindings = bindings;
			_dependencyInjector = dependencyInjector;
			_annotationRegistry = annotationRegistry;
			
			_implementedByCache = new DictionaryMap();
			_providedByCache = new DictionaryMap();
			_singletonCache = new DictionaryMap();
			
			_position = _bindings.length;
			
			_setBinding(new UntargetedBinding(_dependencyInjector, type));
			
			_processAnnotations(type);
		}
		
		private function _setBinding(binding:IBinding):void
		{
			_binding = binding;
			_bindings[_position] = binding;
		}
		
		private function _getClass(typeName:String):Class
		{
			try
			{
				return Class(getDefinitionByName(typeName))
			} catch (e:ReferenceError)
			{
				throw new ReferenceError("Could not find type with name '" + typeName + "' make sure it's compiled");
			}
			
			//unreachable
			return null;
		}
		
		private function _processAnnotations(type:Class):void
		{
			var implementedBy:Class;
			var providedBy:Class;
			
			/*
				both implementedBy and providedBy are filled within this block 
				so we only check for one
			*/
			if (_implementedByCache.containsKey(type))
			{
				implementedBy = Class(_implementedByCache.get(type));
				providedBy = Class(_providedByCache.get(type));
			} else
			{
				var annotationMetadata:Vector.<AnnotationMetadata> = ClassMetadataUtils.getAnnotationMetadata(type);
				var annotation:AnnotationMetadata;
				
				try
				{
					for each (annotation in annotationMetadata)
					{
						switch (annotation.name)
						{
							case AnnotationNames.IMPLEMENTED_BY:
								implementedBy = _getClass(annotation.defaultValue);
								break;
							case AnnotationNames.PROVIDED_BY:
								providedBy = _getClass(annotation.defaultValue);
								break;
						}
					}
				} catch (e:ReferenceError)
				{
					throw new ReferenceError("There was a problem processing annotation " + annotation + " as found on class '" + getQualifiedClassName(type) + "'.\nOriginal message: " + e.message);
				}
				_implementedByCache.put(type, implementedBy);
				_providedByCache.put(type, providedBy);
			}
			
			_proccessScopeAnnotations(type);
			
			if (implementedBy)
			{
				to(implementedBy);
			}
			
			if (providedBy)
			{
				toProvider(providedBy);
			}
		}
		
		public function annotatedWith(annotationOrAnnotations:Object):ILinkedBindingBuilder
		{
			var annotations:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			
			if (annotationOrAnnotations is Class || annotationOrAnnotations is IAnnotation)
			{
				_addAnnotation(annotationOrAnnotations, annotations);
			} else if (annotationOrAnnotations is Array || annotationOrAnnotations is Vector.<Class> || annotationOrAnnotations is Vector.<IAnnotation>)
			{
				var annotationOrAnnotationType:Object;
				for each (annotationOrAnnotationType in annotationOrAnnotations)
				{
					_addAnnotation(annotationOrAnnotationType, annotations);
				}
			} else
			{
				throw new Error("The given object should be a class, an implementation of IAnnotation, an Array, a Vector.<Class> or a Vector.<IAnnotation>");
			}
			
			_setBinding(new AnnotatedBinding(_dependencyInjector, _binding, annotations));
			
			return this;
		}
		
		private function _addAnnotation(annotationOrAnnotationType:Object, annotations:Vector.<IAnnotation>):void
		{
			var annotationType:Class;
			var annotation:IAnnotation;
			
			if (annotationOrAnnotationType is Class)
			{
				annotationType = Class(annotationOrAnnotationType);
				annotation = _annotationRegistry.createInstance(annotationType);
			} else
			{
				annotationType = ClassUtil.getClass(annotationOrAnnotationType);
				if (!annotationType)
				{
					throw new Error("Could not get class of annotation '" + annotationOrAnnotationType + "', make sure it's visible"); 
				}
				annotation = IAnnotation(annotationOrAnnotationType);
			}
			
			annotations.push(annotation);
			_annotationRegistry.registerAnnotationType(annotationType);
		}		
		
		private function _proccessScopeAnnotations(type:Class):void
		{
			var singleton:Boolean;
			
			if (_singletonCache.containsKey(type))
			{
				singleton = _singletonCache.get(type);
			} else
			{
				var annotationMetadata:Vector.<AnnotationMetadata> = ClassMetadataUtils.getAnnotationMetadata(type);
				var annotation:AnnotationMetadata;
				
				outer: for each (annotation in annotationMetadata)
				{
					switch (annotation.name)
					{
						case AnnotationNames.SINGLETON:
							singleton = true;
							break outer;
					}
				}
				
				_singletonCache.put(type, singleton);
			}
			
			if (singleton)
			{
				asSingleton();
			}
		}
		
		public function to(type:Class):IScopedBindingBuilder
		{
			_setBinding(new ClassBinding(_dependencyInjector, _binding, type));
			
			_proccessScopeAnnotations(type)
			
			return this;
		}
		
		public function toInstance(instance:Object):void
		{
			_setBinding(new InstanceBinding(_dependencyInjector, _binding, instance));
		}
		
		public function toProvider(type:Class):IScopedBindingBuilder
		{
			var implementedTypes:Vector.<Class> = ClassMetadataUtils.getImplementedTypes(type);
			
			if (implementedTypes.indexOf(IProvider) > -1)
			{
				_setBinding(new ProviderBinding(_dependencyInjector, _binding, type));
				
				_proccessScopeAnnotations(type);
			} else
			{
				throw new Error("Given class does not implement IProvider");
			}
			return this;
		}
		
		public function toProviderInstance(instance:IProvider):IScopedBindingBuilder
		{
			_setBinding(new ProviderInstanceBinding(_binding, instance));
			
			return this;
		}
		
		public function inScope(scope:IScope):void
		{
			if (_binding is ScopedBinding)
			{
				throw new Error("what to do now?");
			} else
			{
				_setBinding(new ScopedBinding(_binding, scope));
			}
		}
		
		public function asSingleton():void
		{
			inScope(Scopes.SINGLETON);
		}
	}
}