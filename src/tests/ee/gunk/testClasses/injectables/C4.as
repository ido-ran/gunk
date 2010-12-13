package ee.gunk.testClasses.injectables
{
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;

	[Constructor("[Inject]", 0="[Custom]", 1="[Named('cArgument')]")]
	public class C4
	{
		private var _cArgument1:TestType1;
		private var _cArgument2:TestType2;
		
		public function C4(cArgument1:TestType1, cArgument2:TestType2)
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