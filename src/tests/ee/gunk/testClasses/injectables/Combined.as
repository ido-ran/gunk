package ee.gunk.testClasses.injectables
{
	import ee.gunk.testClasses.interfaces.I1;
	import ee.gunk.testClasses.types.TestType1;

	[Custom]
	[Constructor("[Inject]")]
	public class Combined implements I1
	{
		private var _cArgument1:TestType1;
		private var _accessor1:TestType1;
		private var _m1Argument1:TestType1;
		
		public function Combined(cArgument1:TestType1)
		{
			_cArgument1 = cArgument1;
		}
		
		[Inject]
		public var property1:TestType1;
		
		[Inject]
		public function get accessor1():TestType1
		{
			return _accessor1;
		}
		
		public function set accessor1(value:TestType1):void
		{
			_accessor1 = value;
		}
		
		[Inject]
		public function method1(argument1:TestType1):void
		{
			_m1Argument1 = argument1;
		}
		
		public function get cArgument():TestType1
		{
			return _cArgument1;
		}
		
		public function get m1Argument1():TestType1
		{
			return _m1Argument1;
		}
	}
}