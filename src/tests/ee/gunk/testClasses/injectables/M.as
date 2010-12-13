package ee.gunk.testClasses.injectables
{
	import ee.gunk.IProvider;
	import ee.gunk.testClasses.interfaces.I1;
	import ee.gunk.testClasses.interfaces.I2;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	import ee.gunk.testClasses.types.TestType3;

	public class M
	{
		private var _m1Argument1:TestType1;
		private var _m2Argument1:TestType1;
		private var _m2Argument2:TestType2;
		private var _m3Argument1:TestType1;
		private var _m3Argument2:TestType2;
		private var _m4Argument1:TestType1;
		private var _m4Argument2:TestType2;
		private var _m5Argument1:IProvider;
		private var _m6Argument1:I1;
		private var _m6Argument2:I2;
		private var _m7Argument1:TestType3;
		private var _m8Argument1:TestType2;
		
		[Inject]
		public function method1(argument1:TestType1):void
		{
			_m1Argument1 = argument1;
		}
		
		[Inject]
		public function method2(argument1:TestType1, argument2:TestType2):void
		{
			_m2Argument1 = argument1;
			_m2Argument2 = argument2;
		}
		
		[Inject]
		[Arguments(0 = "[Custom]")]
		public function method3(argument1:TestType1, argument2:TestType2):void
		{
			_m3Argument1 = argument1;
			_m3Argument2 = argument2;
		}
		
		[Inject]
		[Arguments(0="[Custom]", 1="[Named('mArgument')]")]
		public function method4(argument1:TestType1, argument2:TestType2):void
		{
			_m4Argument1 = argument1;
			_m4Argument2 = argument2;
		}
		
		[Inject]
		[Arguments(0="[Type('ee.gunk.testClasses.types.TestType1')]")]
		public function method5(argument1:IProvider):void
		{
			_m5Argument1 = argument1;
		}
		
		[Inject]
		public function method6(argument1:I1, argument2:I2):void
		{
			_m6Argument1 = argument1;
			_m6Argument2 = argument2;
		}
		
		[Inject]
		public function method7(argument1:TestType3):void
		{
			_m7Argument1 = argument1;
		}

		[Provides]
		public function method8(argument1:TestType1):TestType2
		{
			return new TestType2();
		}
		
		public function get m1Argument1():TestType1
		{
			return _m1Argument1;
		}

		public function get m2Argument1():TestType1
		{
			return _m2Argument1;
		}

		public function get m2Argument2():TestType2
		{
			return _m2Argument2;
		}

		public function get m3Argument1():TestType1
		{
			return _m3Argument1;
		}

		public function get m3Argument2():TestType2
		{
			return _m3Argument2;
		}

		public function get m4Argument1():TestType1
		{
			return _m4Argument1;
		}

		public function get m4Argument2():TestType2
		{
			return _m4Argument2;
		}

		public function get m5Argument1():IProvider
		{
			return _m5Argument1;
		}

		public function get m6Argument1():I1
		{
			return _m6Argument1;
		}

		public function get m6Argument2():I2
		{
			return _m6Argument2;
		}

		public function get m7Argument1():TestType3
		{
			return _m7Argument1;
		}
		
		public function get m8Argument1():TestType2
		{
			return _m8Argument1;
		}
	}
}