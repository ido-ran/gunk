package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IKeyAwareProvider;
	import ee.gunk.IProvider;

	internal class ScopeProviderWrapper implements IKeyAwareProvider
	{
		private var _scopeProvider:IProvider;
		
		public function ScopeProviderWrapper(scopeProvider:IProvider)
		{
			_scopeProvider = scopeProvider;
		}
		
		public function get():Object
		{
			return InternalFactoryWrapper(_scopeProvider.get()).instance;
		}
		
		public function getFor(key:IKey):Object
		{
			if (_scopeProvider is IKeyAwareProvider)
			{
				return InternalFactoryWrapper(IKeyAwareProvider(_scopeProvider).getFor(key)).instance;
			} else
			{
				return get();
			}
		}
	}
}