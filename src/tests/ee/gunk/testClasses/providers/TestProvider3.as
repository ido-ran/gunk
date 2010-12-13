package ee.gunk.testClasses.providers
{
	import ee.gunk.IKey;
	import ee.gunk.IKeyAwareProvider;
	import ee.gunk.testClasses.types.TestType1;
	
	public class TestProvider3 implements IKeyAwareProvider
	{
		public function TestProvider3()
		{
		}
		
		public function getFor(key:IKey):Object
		{
			return new TestType1();
		}
		
		public function get():Object
		{
			throw new Error("get not implemented");
		}
	}
}