package ee.gunk.features
{
	import ee.gunk.AbstractModule;
	import ee.gunk.Gunk;
	import ee.gunk.IInjector;
	import ee.gunk.annotation.Names;
	import ee.gunk.testClasses.annotations.Custom;
	import ee.gunk.testClasses.injectables.A;
	import ee.gunk.testClasses.injectables.P;
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
	import org.hamcrest.object.nullValue;

	public class PropertyInjectionTest extends AbstractModule
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
			
			bind(TestType2).annotatedWith(Custom).toInstance(_customInstance2);
			bind(TestType1).annotatedWith(Names.named("property")).toInstance(_customInstance1);
		}
		
		[Test]
		public function testProperty():void
		{
			var p:P = P(_i.getInstance(P));
			assertThat(p.property1, notNullValue());
		}
		
		[Test]
		public function testCustomAnnotation():void
		{
			var p:P = P(_i.getInstance(P));
			assertThat(p.property2, equalTo(_customInstance2));
		}
		
		[Test]
		public function testNamed():void
		{
			var o:P = P(_i.getInstance(P));
			assertThat(o.property3, equalTo(_customInstance1));
		}
		
		[Test]
		public function testProvider():void
		{
			var o:P = P(_i.getInstance(P));
			assertThat(o.property4, notNullValue());
			assertThat(o.property4.get(), instanceOf(TestType1));
		}
		
		[Test]
		public function testImplementedBy():void
		{
			var o:P = P(_i.getInstance(P));
			assertThat(o.property5, notNullValue());
			assertThat(o.property5, instanceOf(TestType1));
		}
		
		[Test]
		public function testProvidedBy():void
		{
			var o:P = P(_i.getInstance(P));
			assertThat(o.property6, notNullValue());
			assertThat(o.property6, instanceOf(TestType2));
		}
		
		[Test]
		public function testSingleton():void
		{
			var o1:P = P(_i.getInstance(P));
			var o2:P = P(_i.getInstance(P));
			assertThat(o1.property7, notNullValue());
			assertThat(o1.property7, equalTo(o2.property7));
		}		
		
		[Test]
		public function testNotInjected():void
		{
			var o:P = P(_i.getInstance(P));
			assertThat(o.property8, nullValue());
		}		
	}
}