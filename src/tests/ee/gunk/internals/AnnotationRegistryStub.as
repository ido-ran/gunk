package ee.gunk.internals
{
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.IAnnotationFactory;
	import ee.gunk.metadata.AnnotationMetadata;
	import ee.gunk.testClasses.annotations.Custom;
	
	public class AnnotationRegistryStub implements IAnnotationRegistry
	{
		private var _registerAnnotationFactoryCalled:Boolean;
		
		public function AnnotationRegistryStub()
		{
		}
		
		public function createInstance(annotationType:Class):IAnnotation
		{
			return new Custom();
		}
		
		public function registerAnnotationType(annotationType:Class):void
		{
		}
		
		public function registerAnnotationFactory(annotationType:Class, annotationFactory:IAnnotationFactory):void
		{
			_registerAnnotationFactoryCalled = true;
		}
		
		public function getAnnotation(annotationMetadata:AnnotationMetadata):IAnnotation
		{
			return new Custom();
		}
		
		public function get registerAnnotationFactoryCalled():Boolean
		{
			return _registerAnnotationFactoryCalled;
		}
	}
}