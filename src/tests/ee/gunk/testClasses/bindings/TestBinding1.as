package ee.gunk.testClasses.bindings
{
	import ee.gunk.IBinding;
	import ee.gunk.IProvider;
	import ee.gunk.IKey;
	
	public class TestBinding1 implements IBinding
	{
		private var _key:IKey;
		private var _provider:IProvider;
		
		public function TestBinding1(key:IKey, provider:IProvider)
		{
			_key = key;
			_provider = provider;
		}
		
		public function get provider():IProvider
		{
			return _provider;
		}
		
		public function get key():IKey
		{
			return _key;
		}
	}
}