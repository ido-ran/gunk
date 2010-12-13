package ee.gunk.internals
{
	import ee.gunk.IModule;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.IBinder;
	import ee.gunk.metadata.AnnotationMetadata;
	import ee.gunk.metadata.ClassMetadata;
	import ee.gunk.metadata.IClassMetadataFactory;
	import ee.gunk.metadata.MethodMetadata;
	
	public class ProviderMethodsBinder
	{
		private var _binder:IBinder;
		private var _classMetadataFactory:IClassMetadataFactory;
		private var _annotationRegistry:IAnnotationRegistry;
		
		public function ProviderMethodsBinder(binder:IBinder, classMetadataFactory:IClassMetadataFactory, annotationRegistry:IAnnotationRegistry)
		{
			_binder = binder;
			_classMetadataFactory = classMetadataFactory;
			_annotationRegistry = annotationRegistry;
		}
		

	}
}