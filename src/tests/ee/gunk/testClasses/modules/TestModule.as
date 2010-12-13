package ee.gunk.testClasses.modules
{
	import ee.gunk.IModule;
	import ee.gunk.IBinder;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	
	public class TestModule implements IModule
	{
		private var _binder:IBinder;
		private var _testType:TestType2;
		
		public function TestModule()
		{
			_testType = new TestType2();
		}
		
		public function configureWithBinder(binder:IBinder):void
		{
			_binder = binder;
		}
		
		[Provides]
		public function getTestType(testType:TestType1):TestType2
		{
			return _testType;
		}
		
		public function get testType():TestType2
		{
			return _testType;
		}
		
		public function get binder():IBinder
		{
			return _binder;
		}
	}
}