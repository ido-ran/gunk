package ee.gunk.testClasses.injectables
{
	import ee.gunk.IProvider;
	import ee.gunk.testClasses.interfaces.I1;
	import ee.gunk.testClasses.interfaces.I2;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	import ee.gunk.testClasses.types.TestType3;

	public class A
	{
		private var _accessor1:TestType1;
		private var _accessor2:TestType2;
		private var _accessor3:TestType1;
		private var _accessor4:IProvider;
		private var _accessor5:I1;
		private var _accessor6:I2;
		private var _accessor7:TestType3;
		
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
		[Custom]
		public function get accessor2():TestType2
		{
			return _accessor2;
		}
		
		public function set accessor2(value:TestType2):void
		{
			_accessor2 = value;
		}
		
		[Inject]
		[Named("accessor")]
		public function get accessor3():TestType1
		{
			return _accessor3;
		}
		
		public function set accessor3(value:TestType1):void
		{
			_accessor3 = value;
		}
		
		[Inject]
		[Type("ee.gunk.testClasses.types.TestType1")]
		public function get accessor4():IProvider
		{
			return _accessor4;
		}
		
		public function set accessor4(value:IProvider):void
		{
			_accessor4 = value;
		}
		
		[Inject]
		public function get accessor5():I1
		{
			return _accessor5;
		}
		
		public function set accessor5(value:I1):void
		{
			_accessor5 = value;
		}
		
		[Inject]
		public function get accessor6():I2
		{
			return _accessor6;
		}
		
		public function set accessor6(value:I2):void
		{
			_accessor6 = value;
		}
		
		[Inject]
		public function get accessor7():TestType3
		{
			return _accessor7;
		}
		
		public function set accessor7(value:TestType3):void
		{
			_accessor7 = value;
		}
	}
}