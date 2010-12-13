package ee.gunk.annotation
{
	import ee.gunk.metadata.AnnotationMetadata;

	/**
	 * Defines an annotation factory as used by DI
	 * 
	 * @see ee.di.binder.IBinder#bindAnnotationFactory()
	 * @see ee.di.IModule
	 */ 
	public interface IAnnotationFactory
	{
		/**
		 * Creates a default annotation instance.
		 */
		function createAnnotation():IAnnotation;
		
		/**
		 * Creates an annotation instance using the given metadata.
		 * 
		 * @param annotationMetadata	The metadata containing information about the annotation as 
		 * 								found in the code.
		 */
		function createAnnotationFromMetadata(annotationMetadata:AnnotationMetadata):IAnnotation;
	}
}