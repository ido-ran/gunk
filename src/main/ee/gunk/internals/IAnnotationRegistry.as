package ee.gunk.internals
{
	import ee.gunk.metadata.AnnotationMetadata;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.IAnnotationFactory;

	/**
	 * @private
	 */
	internal interface IAnnotationRegistry
	{
		function createInstance(annotationType:Class):IAnnotation;
		function registerAnnotationType(annotationType:Class):void;
		function registerAnnotationFactory(annotationType:Class, annotationFactory:IAnnotationFactory):void;
		function getAnnotation(annotationMetadata:AnnotationMetadata):IAnnotation;
	}
}