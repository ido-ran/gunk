package ee.gunk.testClasses.scopes
{
	import ee.gunk.IKey;
	import ee.gunk.IProvider;
	import ee.gunk.IScope;
	
	public class TestScope implements IScope
	{
		public function TestScope()
		{
		}
		
		public function scope(key:IKey, provider:IProvider):IProvider
		{
			return null;
		}
		
		public function toString():String
		{
			return null;
		}
	}
}