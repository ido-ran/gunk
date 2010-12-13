package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IProvider;

	/**
	 * @private
	 */
	internal final class InstanceProvider implements IProvider
	{
		private var _dependencyInjector:IDependencyInjector;
		private var _instance:Object;
		private var _injected:Boolean;
		
		public function InstanceProvider(dependencyInjector:IDependencyInjector, instance:Object)
		{
			_instance = instance;
		}
		
		public function get():Object
		{
			if (!_injected)
			{
				_dependencyInjector.injectDependencies(_instance);
			}
			
			return _instance;
		}
	}
}