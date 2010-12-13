package ee.gunk.internals
{
	import ee.gunk.IInjector;
	import ee.gunk.metadata.ClassMetadataFactory;
	import ee.gunk.metadata.IClassMetadataFactory;

	public class InjectorCreator
	{
		private var _annotationRegistry:IAnnotationRegistry;
		private var _dependencyFactory:IDependencyFactory;
		private var _classMetadataFactory:IClassMetadataFactory;
		
		public function InjectorCreator()
		{
			_annotationRegistry = new AnnotationRegistry();
			_classMetadataFactory = new ClassMetadataFactory();
			_dependencyFactory = new DependencyFactory(_annotationRegistry, _classMetadataFactory);
		}
		
		public function create(modules:Array):IInjector
		{
			return new Injector(_annotationRegistry, _classMetadataFactory, _dependencyFactory, modules);
		}
		
		public function get annotationRegistry():IAnnotationRegistry
		{
			return _annotationRegistry;
		}
	}
}