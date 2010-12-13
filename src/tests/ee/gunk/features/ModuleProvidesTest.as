package ee.gunk.features
{
	import ee.gunk.AbstractModule;
	import ee.gunk.Gunk;
	import ee.gunk.IInjector;
	import ee.gunk.testClasses.interfaces.I1;
	import ee.gunk.testClasses.interfaces.I2;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class ModuleProvidesTest extends AbstractModule
	{
		private var _i:IInjector;
		private var _testType:I2;
		
		[Before]
		public function setUp():void
		{
			_testType = new TestType2();
			_i = Gunk.createInjector(this);
		}
		
		[After]
		public function tearDown():void
		{
			_i = null;
		}
		
		protected override function configure():void
		{
			//make sure TestType1 is compiled
			TestType1;
		}
		
		[Provides]
		public function getTestType(testType1:I1):I2
		{
			if (!testType1)
			{
				throw new Error("Could not perform duty without testType1 passed in");
			}
			
			return _testType; 
		}
		
		[Test]
		public function testProvides():void
		{
			var o:Object = _i.getInstance(I2);
			assertThat(o, equalTo(_testType));
		}
	}
}