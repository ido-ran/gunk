package ee.gunk.internals
{
	import ee.gunk.IInjector;
	import ee.gunk.IModule;
	import ee.gunk.IProvider;
	import ee.gunk.IKey;
	import ee.gunk.Key;
	import ee.gunk.IBinder;
	import ee.gunk.IBinding;
	import ee.gunk.metadata.IClassMetadataFactory;

	/**
	 * @private
	 */
	internal final class Injector implements IInjector
	{
		private var _dependencyInjector:IDependencyInjector;
		private var _bindingRegistry:IBindingRegistry;
		private var _binder:IInternalBinder;
		
		public function Injector(annotationRegistry:IAnnotationRegistry, classMetadataFactory:IClassMetadataFactory, modules:Array)
		{
			var dependencyFactory:DependencyFactory = new DependencyFactory(annotationRegistry, classMetadataFactory);
			
			_dependencyInjector = new DependencyInjector(this, dependencyFactory);
			_binder = new Binder(_dependencyInjector, annotationRegistry, classMetadataFactory, dependencyFactory);
			
			_binder.install(new GunkModule(this));
			_configureModules(modules);
		}
		
		private function _configureModules(modules:Array):void
		{
			var i:uint;
			
			for (i = 0; i < modules.length; i++)
			{
				_binder.install(IModule(modules[i]));
			}
		}
		
		public function injectDependencies(object:Object):void
		{
			_dependencyInjector.injectDependencies(object);
		}
		
		public function getInstance(type:Class):Object
		{
			return getProvider(type).get();
		}
		
		public function getProvider(type:Class):IProvider
		{
			return getProviderFor(new Key(type));
		}
		
		public function getProviderFor(key:IKey):IProvider
		{
			return _binder.getBinding(key).provider;
		}
	}
}