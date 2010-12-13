package ee.gunk.testClasses.injectables
{
	import ee.gunk.IProvider;
	import ee.gunk.testClasses.interfaces.I1;
	import ee.gunk.testClasses.interfaces.I2;

	[Constructor("[Inject]")]
	public class C6
	{
		private var _cArgument1:I1;
		private var _cArgument2:I2;
		
		public function C6(cArgument1:I1, cArgument2:I2)
		{
			_cArgument1 = cArgument1;
			_cArgument2 = cArgument2;
		}
		
		public function get cArgument1():I1
		{
			return _cArgument1;
		}
		
		public function get cArgument2():I2
		{
			return _cArgument2;
		}
	}
}