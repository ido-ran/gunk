package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IKey;
	import ee.gunk.IProvider;
	import ee.gunk.IScope;
	
	/**
	 * @private
	 */
	internal final class ScopedBinding extends AbstractBinding
	{
		private var _scope:IScope;
		private var _internalProvider:IInternalFactory;
		private var _provider:IProvider;
		
		public function ScopedBinding(base:IBinding, scope:IScope)
		{
			_scope = scope;
			
			var provider:IProvider = base.provider;
			var key:IKey = base.key;
			
			var finalProvider:IProvider;
			
			if (provider is IInternalFactory)
			{
				/*
					We need to do some special wrapping in order for a context to 
					be present during construction. This makes sure the context is 
					scoped as well.
				*/
				var factoryWrapper:InternalFactoryWrapper = new InternalFactoryWrapper(IInternalFactory(provider));
				var scopeProvider:IProvider = scope.scope(key, factoryWrapper);
				finalProvider = new ScopeProviderWrapper(scopeProvider);
			} else
			{
				finalProvider = scope.scope(key, provider);
			}
			
			super(finalProvider, key);
		}
		
		public function get scope():IScope
		{
			return _scope;
		}
	}
}