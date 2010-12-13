package ee.gunk.testClasses.injectables
{
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;

	[Constructor("[Inject]")]
	public class C2
	{
		private var _cArgument1:TestType1;
		private var _cArgument2:TestType2;
		
		public function C2(cArgument1:TestType1, cArgument2:TestType2)
		{
			_cArgument1 = cArgument1;
			_cArgument2 = cArgument2;
		}
		
		public function get cArgument1():TestType1
		{
			return _cArgument1;
		}
		
		public function get cArgument2():TestType2
		{
			return _cArgument2;
		}
	}
}