package ee.gunk.internals
{
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.IAnnotationFactory;
	import ee.gunk.metadata.AnnotationMetadata;
	import ee.gunk.metadata.ClassMetadataUtils;
	import ee.gunk.util.DictionaryMap;
	import ee.gunk.util.IMap;
	import ee.gunk.util.ObjectMap;
	
	import flash.utils.getQualifiedClassName;

	/**
	 * @private
	 */
	internal final class AnnotationRegistry implements IAnnotationRegistry
	{
		private var _annotationRegistry:IMap;
		private var _annotationInstanceRegistry:IMap;
		private var _annotationFactoryRegistry:IMap;
		
		public function AnnotationRegistry()
		{
			_annotationRegistry = new ObjectMap();
			_annotationInstanceRegistry = new ObjectMap();
			_annotationFactoryRegistry = new DictionaryMap();
		}
		
		public function registerAnnotationFactory(annotationType:Class, annotationFactory:IAnnotationFactory):void
		{
			_annotationFactoryRegistry.put(annotationType, annotationFactory);	
		}
		
		private function _createInternalAnnotationFactory(annotationType:Class):IAnnotationFactory
		{
			var constructorArgumentCount:uint = ClassMetadataUtils.getConstructorArgumentCount(annotationType);
			var factory:IAnnotationFactory = new InternalAnnotationFactory(annotationType, constructorArgumentCount);
			
			return factory;
		}
		
		public function createInstance(annotationType:Class):IAnnotation
		{
			if (_annotationFactoryRegistry.containsKey(annotationType))
			{
				return IAnnotationFactory(_annotationFactoryRegistry.get(annotationType)).createAnnotation();
			} else
			{
				var factory:IAnnotationFactory = _createInternalAnnotationFactory(annotationType);
				
				registerAnnotationFactory(annotationType, factory);
				
				return factory.createAnnotation();
			}
		}
		
		public function registerAnnotationType(annotationType:Class):void
		{
			var implementedTypes:Vector.<Class> = ClassMetadataUtils.getImplementedTypes(annotationType);
			
			if (implementedTypes.indexOf(IAnnotation) > -1)
			{
				var name:String = _getAnnotationName(annotationType);
				
				if (!_annotationRegistry.containsKey(name))
				{
					_annotationRegistry.put(name, annotationType);
				}
				
			} else
			{
				throw new Error("The given annotation class (" + annotationType + ") does not implement IAnnotation");
			}
			
		}

		public function getAnnotation(annotationMetadata:AnnotationMetadata):IAnnotation
		{
			var name:String = annotationMetadata.name;

			if (_annotationRegistry.containsKey(name))
			{
				var annotationType:Class = Class(_annotationRegistry.get(name));
				
				return _createInstanceFromMetadata(annotationType, annotationMetadata);
			} else
			{
				return null;
			}
		}
		
		private function _getAnnotationName(annotationType:Class):String
		{
			return  getQualifiedClassName(annotationType).split("::")[1];
		}
		
		private function _createInstanceFromMetadata(annotationType:Class, annotationMetadata:AnnotationMetadata):IAnnotation
		{
			var hash:String = annotationMetadata.hash;
			
			if (_annotationInstanceRegistry.containsKey(hash))
			{
				return IAnnotation(_annotationInstanceRegistry.get(hash));
			} else
			{
				var annotationInstance:IAnnotation;
				var factory:IAnnotationFactory;
				
				if (_annotationFactoryRegistry.containsKey(annotationType))
				{
					factory = IAnnotationFactory(_annotationFactoryRegistry.get(annotationType));
				} else
				{
					factory = _createInternalAnnotationFactory(annotationType);
				}
				annotationInstance = factory.createAnnotationFromMetadata(annotationMetadata);
				
				_annotationInstanceRegistry.put(hash, annotationInstance);
				
				return annotationInstance;
			}
		}
	}
}