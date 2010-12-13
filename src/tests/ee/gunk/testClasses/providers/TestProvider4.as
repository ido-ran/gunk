package ee.gunk.testClasses.providers
{
	import ee.gunk.IProvider;
	import ee.gunk.testClasses.types.TestType1;
	
	[Singleton]
	public class TestProvider4 implements IProvider
	{
		public function TestProvider4()
		{
		}
		
		public function get():Object
		{
			return new TestType1();
		}
	}
}