package ee.gunk.testClasses.injectables
{
	import ee.gunk.IProvider;

	[Constructor("[Inject]", 0="[Type('ee.gunk.testClasses.types.TestType1')]")]
	public class C5
	{
		private var _cArgument1:IProvider;
		
		public function C5(cArgument1:IProvider)
		{
			_cArgument1 = cArgument1;
		}
		
		public function get cArgument1():IProvider
		{
			return _cArgument1;
		}
	}
}