package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IKeyAwareProvider;
	import ee.gunk.IProvider;
	
	/**
	 * @private
	 */
	internal final class ProviderProvider implements IKeyAwareProvider
	{
		private var _dependencyInjector:IDependencyInjector
		private var _providerType:Class
		
		private var _provider:IProvider;
		
		public function ProviderProvider(dependencyInjector:IDependencyInjector, providerType:Class)
		{
			_dependencyInjector = dependencyInjector;
			_providerType = providerType;
		}
		
		private function _get(key:IKey = null):Object
		{
			if (!_provider)
			{
				_provider = IProvider(_dependencyInjector.createInstance(_providerType));
			}
			
			if (_provider is IKeyAwareProvider)
			{
				return IKeyAwareProvider(_provider).getFor(key);
			} else
			{
				return _provider.get();
			}
		}
		
		public function get():Object
		{
			return _get();
		}
		
		public function getFor(key:IKey):Object
		{
			return _get(key);
		}
	}
}