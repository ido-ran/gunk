package ee.gunk.features
{
	import ee.gunk.AbstractModule;
	import ee.gunk.Gunk;
	import ee.gunk.IInjector;
	import ee.gunk.annotation.Names;
	import ee.gunk.testClasses.annotations.Custom;
	import ee.gunk.testClasses.injectables.C1;
	import ee.gunk.testClasses.injectables.C2;
	import ee.gunk.testClasses.injectables.C3;
	import ee.gunk.testClasses.injectables.C4;
	import ee.gunk.testClasses.injectables.C5;
	import ee.gunk.testClasses.injectables.C6;
	import ee.gunk.testClasses.injectables.C7;
	import ee.gunk.testClasses.interfaces.I1;
	import ee.gunk.testClasses.interfaces.I2;
	import ee.gunk.testClasses.providers.TestProvider2;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	import ee.gunk.testClasses.types.TestType3;
	
	import org.flexunit.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;

	public class ConstructorInjectionTest extends AbstractModule
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
			bind(TestType2).annotatedWith(Names.named("cArgument")).toInstance(_customInstance2);
		}
		
		[Test]
		public function testSingleArgument():void
		{
			var o:C1 = C1(_i.getInstance(C1));
			assertThat(o.cArgument1, notNullValue());
		}
		
		[Test]
		public function testSingleArgumentNoSingleton():void
		{
			var o1:C1 = C1(_i.getInstance(C1));
			var o2:C1 = C1(_i.getInstance(C1));
			assertThat(o1.cArgument1, not(equalTo(o2)));
		}
		
		[Test]
		public function testMultipleArgument():void
		{
			var o:C2 = C2(_i.getInstance(C2));
			assertThat(o.cArgument2, notNullValue());
		}
		
		[Test]
		public function testCustomAnnotation():void
		{
			var o:C3 = C3(_i.getInstance(C3));
			assertThat(o.cArgument1, equalTo(_customInstance1));
		}
		
		[Test]
		public function testNamed():void
		{
			var o:C4 = C4(_i.getInstance(C4));
			assertThat(o.cArgument2, equalTo(_customInstance2));
		}
		
		[Test]
		public function testProvider():void
		{
			var o:C5 = C5(_i.getInstance(C5));
			assertThat(o.cArgument1, notNullValue());
			assertThat(o.cArgument1.get(), instanceOf(TestType1));
		}
		
		[Test]
		public function testImplementedBy():void
		{
			var o:C6 = C6(_i.getInstance(C6));
			assertThat(o.cArgument1, notNullValue());
			assertThat(o.cArgument1, instanceOf(TestType1));
		}
		
		[Test]
		public function testProvidedBy():void
		{
			var o:C6 = C6(_i.getInstance(C6));
			assertThat(o.cArgument2, notNullValue());
			assertThat(o.cArgument2, instanceOf(TestType2));
		}
		
		[Test]
		public function testSingleton():void
		{
			var o1:C7 = C7(_i.getInstance(C7));
			var o2:C7 = C7(_i.getInstance(C7));
			assertThat(o1.cArgument1, notNullValue());
			assertThat(o1.cArgument1, equalTo(o2.cArgument1));
		}
	}
}