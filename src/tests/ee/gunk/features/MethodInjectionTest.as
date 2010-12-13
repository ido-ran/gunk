package ee.gunk.features
{
	import ee.gunk.AbstractModule;
	import ee.gunk.Gunk;
	import ee.gunk.IInjector;
	import ee.gunk.annotation.Names;
	import ee.gunk.testClasses.annotations.Custom;
	import ee.gunk.testClasses.injectables.M;
	import ee.gunk.testClasses.interfaces.I1;
	import ee.gunk.testClasses.interfaces.I2;
	import ee.gunk.testClasses.providers.TestProvider2;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	import ee.gunk.testClasses.types.TestType3;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;

	public class MethodInjectionTest extends AbstractModule
	{	
		private var _i:IInjector;
		private var _customInstance1:TestType1;
		private var _customInstance2:TestType2;
		
		[Before]
		public function setUp():void
		{
			_customInstance1 = new TestType1();
			_customInstance2 = new TestType2();
			_i = Gunk.createInjector(this);
		}
		
		[After]
		public function tearDown():void
		{
			_i = null;
			_customInstance1 = null;
			_customInstance2 = null;
		}
		
		protected override function configure():void
		{
			//make sure TestProvider2 is compiled
			TestProvider2;
			
			bind(TestType1).annotatedWith(Custom).toInstance(_customInstance1);
			bind(TestType2).annotatedWith(Names.named("mArgument")).toInstance(_customInstance2);
		}
		
		[Test]
		public function testSingleArgument():void
		{
			var m:M = M(_i.getInstance(M));
			assertThat(m.m1Argument1, notNullValue());
		}
		
		[Test]
		public function testMultipleArguments():void
		{
			var m:M = M(_i.getInstance(M));
			assertThat(m.m2Argument2, notNullValue());
		}
		
		[Test]
		public function testCustomAnnotation():void
		{
			var m:M = M(_i.getInstance(M));
			assertThat(m.m3Argument1, equalTo(_customInstance1));
		}
		
		[Test]
		public function testNamed():void
		{
			var o:M = M(_i.getInstance(M));
			assertThat(o.m4Argument2, equalTo(_customInstance2));
		}
		
		[Test]
		public function testProvider():void
		{
			var o:M = M(_i.getInstance(M));
			assertThat(o.m5Argument1, notNullValue());
			assertThat(o.m5Argument1.get(), instanceOf(TestType1));
		}
		
		[Test]
		public function testImplementedBy():void
		{
			var o:M = M(_i.getInstance(M));
			assertThat(o.m6Argument1, notNullValue());
			assertThat(o.m6Argument1, instanceOf(TestType1));
		}
		
		[Test]
		public function testProvidedBy():void
		{
			var o:M = M(_i.getInstance(M));
			assertThat(o.m6Argument2, notNullValue());
			assertThat(o.m6Argument2, instanceOf(TestType2));
		}
		
		[Test]
		public function testSingleton():void
		{
			var o1:M = M(_i.getInstance(M));
			var o2:M = M(_i.getInstance(M));
			assertThat(o1.m7Argument1, notNullValue());
			assertThat(o1.m7Argument1, equalTo(o2.m7Argument1));
		}		
		
		[Test]
		public function testNotInjected():void
		{
			var o:M = M(_i.getInstance(M));
			assertThat(o.m8Argument1, nullValue());
		}		
	}
}