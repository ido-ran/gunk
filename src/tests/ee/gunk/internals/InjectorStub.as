package ee.gunk.internals
{
	import ee.gunk.IInjector;
	import ee.gunk.IProvider;
	import ee.gunk.IKey;
	
	public class InjectorStub implements IInjector
	{
		private var _provider:IProvider;
		
		public function InjectorStub(provider:IProvider)
		{
			_provider = provider;
		}
		
		public function injectDependencies(object:Object):void
		{
		}
		
		public function getInstance(type:Class):Object
		{
			return null;
		}
		
		public function getProvider(type:Class):IProvider
		{
			return null;
		}
		
		public function getProviderFor(key:IKey):IProvider
		{
			return _provider;
		}
	}
}