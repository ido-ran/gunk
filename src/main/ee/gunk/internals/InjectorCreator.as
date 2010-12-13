package ee.gunk.internals
{
	import ee.gunk.IInjector;
	import ee.gunk.metadata.ClassMetadataFactory;
	import ee.gunk.metadata.IClassMetadataFactory;

	/**
	 * Gives Gunk access to the Injector implementation, please use Gunk's <code>createInjector</code> 
	 * method.
	 * 
	 * @see ee.gunk.Gunk#createInjector()
	 */
	public class InjectorCreator
	{
		private var _annotationRegistry:IAnnotationRegistry;
		private var _classMetadataFactory:IClassMetadataFactory;
		
		public function InjectorCreator()
		{
			_annotationRegistry = new AnnotationRegistry();
			_classMetadataFactory = new ClassMetadataFactory();
		}
		
		public function create(modules:Array):IInjector
		{
			return new Injector(_annotationRegistry, _classMetadataFactory, modules);
		}
	}
}