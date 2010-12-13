package ee.gunk.testClasses.injectables
{
	import ee.gunk.testClasses.types.TestType1;

	[Constructor("[Inject]")]
	public class C1
	{
		private var _cArgument1:TestType1;
		
		public function C1(cArgument1:TestType1)
		{
			_cArgument1 = cArgument1;
		}
		
		public function get cArgument1():TestType1
		{
			return _cArgument1;
		}
	}
}