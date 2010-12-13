package ee.gunk.testClasses.injectables
{
	import ee.gunk.IProvider;
	import ee.gunk.testClasses.types.TestType3;

	[Constructor("[Inject]")]
	public class C7
	{
		private var _cArgument1:TestType3;
		
		public function C7(cArgument1:TestType3)
		{
			_cArgument1 = cArgument1;
		}
		
		public function get cArgument1():TestType3
		{
			return _cArgument1;
		}
	}
}