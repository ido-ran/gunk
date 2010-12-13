package ee.gunk.internals
{
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.IAnnotationFactory;
	import ee.gunk.metadata.AnnotationMetadata;

	/**
	 * @private
	 */
	internal final class InternalAnnotationFactory implements IAnnotationFactory
	{
		private var _type:Class;
		private var _constructorArgumentCount:uint;
		
		public function InternalAnnotationFactory(type:Class, constructorArgumentCount:uint)
		{
			_type = type;
			_constructorArgumentCount = constructorArgumentCount;
		}
		
		public function createAnnotation():IAnnotation
		{
			switch (_constructorArgumentCount)
			{
				case 0:
					return new _type();
				case 1:
					return new _type(null);
				case 2:
					return new _type(null, null);
				default:
					throw new Error("InternalAnnotationFactory an not instantiate annotations with more than 2 constructor arguments");
			}
		}
		
		public function createAnnotationFromMetadata(annotationMetadata:AnnotationMetadata):IAnnotation
		{
			switch (_constructorArgumentCount)
			{
				case 0:
					return new _type();
				case 1:
					return new _type(annotationMetadata.defaultValue);
				case 2:
					return new _type(annotationMetadata.defaultValue, annotationMetadata.values);
				default:
					throw new Error("InternalAnnotationFactory an not instantiate annotations with more than 2 constructor arguments");
			}
		}
	}
}