package ee.gunk.internals
{
	import ee.gunk.IBinder;
	import ee.gunk.IBinding;
	import ee.gunk.IKey;
	import ee.gunk.IModule;
	import ee.gunk.IProvider;
	import ee.gunk.Key;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.IAnnotationFactory;
	import ee.gunk.binder.IAnnotatedBindingBuilder;
	import ee.gunk.binder.ILinkedBindingBuilder;
	import ee.gunk.metadata.AnnotationMetadata;
	import ee.gunk.metadata.ClassMetadata;
	import ee.gunk.metadata.IClassMetadataFactory;
	import ee.gunk.metadata.MethodMetadata;
	
	/**
	 * @private
	 */
	internal final class Binder implements IInternalBinder
	{
		private var _dependencyInjector:IDependencyInjector;
		private var _annotationRegistry:IAnnotationRegistry;
		private var _classMetadataFactory:IClassMetadataFactory;
		private var _dependencyFactory:IDependencyFactory;
		
		private var _bindingRegistry:IBindingRegistry;
		private var _bindings:Vector.<IBinding>;
		
		public function Binder(dependencyInjector:IDependencyInjector, annotationRegistry:IAnnotationRegistry, classMetadataFactory:IClassMetadataFactory, dependencyFactory:IDependencyFactory)
		{
			_dependencyInjector = dependencyInjector;
			_annotationRegistry = annotationRegistry;
			_classMetadataFactory = classMetadataFactory;
			_dependencyFactory = dependencyFactory;
			
			_bindings = new Vector.<IBinding>();
			
			_bindingRegistry = new BindingRegistry();
		}
		
		public function bind(type:Class):IAnnotatedBindingBuilder
		{
			return new BindingBuilder(_bindings, _dependencyInjector, _annotationRegistry, type);
		}
		
		public function bindKey(key:IKey):ILinkedBindingBuilder
		{
			return new KeyBindingBuilder(_bindings, _dependencyInjector, _annotationRegistry, key);
		}
		
		public function bindAnnotationFactory(annotationType:Class, annotationFactory:IAnnotationFactory):void
		{
			_annotationRegistry.registerAnnotationFactory(annotationType, annotationFactory);
		}
		
		public function getBinding(key:IKey):IBinding
		{
			if (!_bindingRegistry.hasBinding(key))
			{
				//try to bind the key
				bindKey(key);
				_updateBindingRegistry();
			}
			
			return _bindingRegistry.getBinding(key);
		}
		
		private function _updateBindingRegistry():void
		{
			var binding:IBinding;
			for each (binding in _bindings)
			{
				_bindingRegistry.addBinding(binding);
			}
			
			_bindings.length = 0;
		}
		
		public function install(module:IModule):void
		{
			//configure
			module.configureWithBinder(this);
			_updateBindingRegistry();
			//process any provides methods
			_bindProviderMethods(module);
			_updateBindingRegistry();
		}
		
		private function _bindProviderMethods(module:IModule):void
		{
			var classMetadata:ClassMetadata = _classMetadataFactory.getClassMetadata(module);
			
			if (classMetadata && classMetadata.methods)
			{
				var methodMetadata:MethodMetadata;
				var methodAnnotations:Vector.<IAnnotation>;
				var methodAnnotation:IAnnotation;
				var annotation:AnnotationMetadata;
				var foundProvidesMethod:Boolean;
				
				for each (methodMetadata in classMetadata.methods)
				{
					foundProvidesMethod = false;
					methodAnnotations = null;
					//loop through the annotations to find a Provides annotation
					for each (annotation in methodMetadata.annotations)
					{
						if (annotation.name == AnnotationNames.PROVIDES)
						{
							foundProvidesMethod = true;
							methodAnnotation = null;
						} else
						{
							methodAnnotation = _annotationRegistry.getAnnotation(annotation);
						}
						
						//add the method annotation in case this method is a Provides method 
						if (methodAnnotation)
						{
							if (!methodAnnotations)
							{
								methodAnnotations = new Vector.<IAnnotation>();
							}
							methodAnnotations.push(methodAnnotation);
						}
					}
					
					if (foundProvidesMethod)
					{
						var methodDependencies:MethodDependencies = _dependencyFactory.createMethodDependencies(methodMetadata, false);
						var method:Function = module[methodMetadata.name];
						var key:Key = new Key(methodMetadata.type, methodAnnotations);
						var methodProvider:IProvider = new MethodProvider(_dependencyInjector, method, methodDependencies.argumentDependencies);
						
						bindKey(key).toProviderInstance(methodProvider);
					}
				}
			}
		}
	}
}