package ee.gunk.testClasses.annotations
{
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.IAnnotationFactory;
	import ee.gunk.metadata.AnnotationMetadata;

	public class Custom2Factory implements IAnnotationFactory
	{
		public function createAnnotation():IAnnotation
		{
			return new Custom2(Custom2);
		}
		
		public function createAnnotationFromMetadata(annotationMetadata:AnnotationMetadata):IAnnotation
		{
			var c:Custom2 = new Custom2(Custom2);
			c.defaultValue = annotationMetadata.defaultValue;
			c.values = annotationMetadata.values;
			
			return c;
		}
	}
}