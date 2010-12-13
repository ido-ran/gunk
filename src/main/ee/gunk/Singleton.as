package ee.gunk
{
	import ee.gunk.provider.SingletonProvider;
	import ee.gunk.util.DictionaryMap;
	import ee.gunk.util.IMap;

	/**
	 * This scope creates instances of SingletonProvider which are cached 
	 * for each instance of provider.
	 * 
	 * @see ee.gunk.provider.SingletonProvider
	 */
	public class Singleton implements IScope
	{
		static private var _singletons:IMap = new DictionaryMap();
		
		public function Singleton()
		{
		}
		
		/**
		 * Creates an instance of SingletonProvider.
		 */
		public function scope(key:IKey, provider:IProvider):IProvider
		{
			if (!_singletons.containsKey(provider))
			{
				_singletons.put(provider, new SingletonProvider(provider));
			}
			
			return IProvider(_singletons.get(provider));
		}
		
		public function toString():String
		{
			return "Scopes.SINGLETON";
		}
	}
}