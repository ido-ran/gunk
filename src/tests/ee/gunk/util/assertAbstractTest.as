package ee.gunk.util
{

	public class assertAbstractTest
	{
		[Test(expects="Error")]
		public function testAssertAbstract():void
		{
			assertAbstract(this, assertAbstractTest);
		}
	}
}