package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.Key;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.metadata.AnnotationMetadata;
	import ee.gunk.metadata.ClassMetadata;
	import ee.gunk.metadata.IClassMetadataFactory;
	import ee.gunk.metadata.MethodMetadata;
	import ee.gunk.metadata.PropertyMetadata;
	import ee.gunk.metadata.TypeMetadata;
	import ee.gunk.util.ClassUtil;
	import ee.gunk.util.DictionaryMap;
	import ee.gunk.util.IMap;
	import ee.gunk.util.ObjectMap;

	/**
	 * @private
	 */
	internal final class DependencyFactory implements IDependencyFactory
	{
		private var _annotationRegistry:IAnnotationRegistry;
		
		private var _classMetadataFactory:IClassMetadataFactory;
		private var _dependencyRegistry:IMap;
		private var _classDependencyCache:IMap;
		
		public function DependencyFactory(annotationRegistry:IAnnotationRegistry, classMetadataFactory:IClassMetadataFactory)
		{
			_annotationRegistry = annotationRegistry;
			
			_classMetadataFactory = classMetadataFactory;
			_dependencyRegistry = new ObjectMap();
			_classDependencyCache = new DictionaryMap();
		}
		
		public function createDependency(type:Class, annotations:Vector.<IAnnotation>):IKey
		{
			var dependency:IKey = new Key(type, annotations);
			
			var hash:String = dependency.fullHash;
			
			if (_dependencyRegistry.containsKey(hash))
			{
				dependency = IKey(_dependencyRegistry.get(hash));
			} else
			{
				_dependencyRegistry.put(hash, dependency);
			}
			
			return dependency;
		}
		
		public function createClassDependencies(object:Object):ClassDependencies
		{
			var type:Class;
			
			if (object is Class)
			{
				type = Class(object);
			} else
			{
				type = ClassUtil.getClass(object);
			}
			
			if (_classDependencyCache.containsKey(type))
			{
				return ClassDependencies(_classDependencyCache.get(type));
			} else
			{
				var classMetadata:ClassMetadata = _classMetadataFactory.getClassMetadata(type);
				
				var constructorDependencies:MethodDependencies;
				var propertyDependencies:Vector.<PropertyDependency>;
				var methodDependencies:Vector.<MethodDependencies>;
				
				if (classMetadata)
				{
					constructorDependencies = classMetadata.constructor ? createMethodDependencies(classMetadata.constructor) : null;
					propertyDependencies = classMetadata.properties ? _createPropertyDependencies(classMetadata.properties) : null;
					methodDependencies = classMetadata.methods ? _createMethodDependencies(classMetadata.methods) : null;
				}
				
				var classDependencies:ClassDependencies;
				
				if (constructorDependencies || propertyDependencies || methodDependencies)
				{
					classDependencies = new ClassDependencies(constructorDependencies, propertyDependencies, methodDependencies);
				} else
				{
					classDependencies = null;
				}
				
				_classDependencyCache.put(type, classDependencies);
				
				return classDependencies;
			}
		}
		
		private function _createMethodDependencies(methodsMetadata:Vector.<MethodMetadata>):Vector.<MethodDependencies>
		{
			var methodDependencies:Vector.<MethodDependencies>;
			var methodMetadata:MethodMetadata;
			var methodDependency:MethodDependencies;
			
			for each (methodMetadata in methodsMetadata)
			{
				methodDependency = createMethodDependencies(methodMetadata);
				
				if (!methodDependency)
				{
					continue;
				}
				
				if (!methodDependencies)
				{
					methodDependencies = new Vector.<MethodDependencies>();
				}
				
				methodDependencies.push(methodDependency);
			}
			
			return methodDependencies;
		}
		
		public function createMethodDependencies(methodMetadata:MethodMetadata, requiresInjectAnnotation:Boolean = true):MethodDependencies
		{
			var createMethodDependency:Boolean;
			
			if (methodMetadata.annotations)
			{
				var annotationsCreationResult:AnnotationsCreationResult = _createAnnotations(methodMetadata.annotations);
				createMethodDependency = !requiresInjectAnnotation || annotationsCreationResult.hasInjectAnnotation;
				annotations = annotationsCreationResult.annotations
			} else
			{
				createMethodDependency = false;
			}
			
			if (createMethodDependency)
			{
				var argumentDependencies:Vector.<IKey>;
				var methodArguments:Vector.<TypeMetadata> = methodMetadata.arguments;
				var i:uint;
				var argumentMetadata:TypeMetadata;
				
				var annotations:Vector.<IAnnotation>;
				var argumentAnnotations:Vector.<IAnnotation>;
				
				if (methodArguments)
				{
					for (i = 0; i < methodArguments.length; i++)
					{
						argumentMetadata = methodArguments[i];
						
						if (argumentMetadata.annotations)
						{
							argumentAnnotations = _createAnnotations(argumentMetadata.annotations).annotations;
						} else
						{
							argumentAnnotations = null;
						}
						
						if (!argumentDependencies)
						{
							argumentDependencies = new Vector.<IKey>();
						}
						
						argumentDependencies.push(createDependency(argumentMetadata.type, argumentAnnotations));
					}
				}
				
				if (argumentDependencies)
				{
					return new MethodDependencies(methodMetadata.name, argumentDependencies);
				} else
				{
					return null;
				}
			} else
			{
				return null;
			}
		}
		
		private function _createPropertyDependencies(propertyMetadata:Vector.<PropertyMetadata>):Vector.<PropertyDependency>
		{
			var propertyDependencies:Vector.<PropertyDependency>;
			var propertyDependency:PropertyDependency;
			
			for each (var metadata:PropertyMetadata in propertyMetadata)
			{
				propertyDependency = _createPropertyDependency(metadata);
				
				if (!propertyDependency)
				{
					continue;	
				}
				
				if (!propertyDependencies)
				{
					propertyDependencies = new Vector.<PropertyDependency>();
				}
				
				propertyDependencies.push(propertyDependency);
			}
			
			return propertyDependencies;
		}
		
		private function _createPropertyDependency(propertyMetadata:PropertyMetadata):PropertyDependency
		{
			var annotationsCreationResult:AnnotationsCreationResult = _createAnnotations(propertyMetadata.annotations);
			
			if (annotationsCreationResult.hasInjectAnnotation)
			{
				var dependency:IKey = createDependency(propertyMetadata.type, annotationsCreationResult.annotations);
				return new PropertyDependency(propertyMetadata.name, dependency);
			} else
			{
				return null;
			}
		}
		
		private function _createAnnotations(annotationsMetadata:Vector.<AnnotationMetadata>):AnnotationsCreationResult
		{
			var annotations:Vector.<IAnnotation>;
			var annotationsCreationResult:AnnotationsCreationResult = new AnnotationsCreationResult();
			
			var annotationMetadata:AnnotationMetadata;
			var annotation:IAnnotation;
			for each (annotationMetadata in annotationsMetadata)
			{
				if (annotationMetadata.name == AnnotationNames.INJECT)
				{
					annotationsCreationResult.hasInjectAnnotation = true;
				} else
				{
					annotation = _annotationRegistry.getAnnotation(annotationMetadata);
					
					if (annotation)
					{
						if (!annotations)
						{
							annotations = new Vector.<IAnnotation>();
							annotationsCreationResult.annotations = annotations;
						}
						
						annotations.push(annotation);
					}
				}
			}
			
			return annotationsCreationResult;
		}
	}
}
import ee.gunk.annotation.IAnnotation;

class AnnotationsCreationResult
{
	public var annotations:Vector.<IAnnotation>;
	public var hasInjectAnnotation:Boolean;
}