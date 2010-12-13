package ee.gunk.testClasses.providers
{
	import ee.gunk.IProvider;
	import ee.gunk.testClasses.types.TestType2;

	public class TestProvider2 implements IProvider
	{
		public function TestProvider2()
		{
		}
		
		public function get():Object
		{
			return new TestType2();
		}
	}
}