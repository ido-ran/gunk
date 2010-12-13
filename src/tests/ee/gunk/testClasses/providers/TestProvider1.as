package ee.gunk.testClasses.providers
{
	import ee.gunk.IProvider;
	import ee.gunk.testClasses.types.TestType1;

	public class TestProvider1 implements IProvider
	{
		public function TestProvider1()
		{
		}
		
		public function get():Object
		{
			return new TestType1();
		}
	}
}