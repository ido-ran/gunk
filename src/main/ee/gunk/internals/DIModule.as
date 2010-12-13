package ee.gunk.internals
{
	import ee.gunk.IBinder;
	import ee.gunk.IInjector;
	import ee.gunk.IModule;
	import ee.gunk.IProvider;
	import ee.gunk.annotation.Type;
	import ee.gunk.provider.DynamicProvider;

	/**
	 * @private
	 */
	internal class DIModule implements IModule
	{
		private var _injector:IInjector;
		
		public function DIModule(injector:IInjector)
		{
			_injector = injector;
		}
		
		public function configureWithBinder(binder:IBinder):void
		{
			binder.bind(IInjector).toInstance(_injector);
			binder.bind(IProvider).annotatedWith(Type).toProvider(DynamicProvider).asSingleton();
		}
	}
}