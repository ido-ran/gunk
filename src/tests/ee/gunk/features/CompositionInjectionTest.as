package ee.gunk.features
{
	import ee.gunk.AbstractModule;
	import ee.gunk.Gunk;
	import ee.gunk.IInjector;
	import ee.gunk.annotation.Names;
	import ee.gunk.testClasses.annotations.Custom;
	import ee.gunk.testClasses.injectables.Composition;
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

	public class CompositionInjectionTest extends AbstractModule
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
			//make sure these are compiled
			TestProvider2;
			TestType1;
			
			bind(TestType1).annotatedWith(Custom).toInstance(_customInstance1);
			bind(TestType2).annotatedWith(Names.named("mArgument")).toInstance(_customInstance2);
		}
		
		[Test]
		public function testProperty_constructorInjection():void
		{
			var m:Composition = Composition(_i.getInstance(Composition));
			assertThat(m.constructorInjection, notNullValue());
		}
		
		[Test]
		public function testProperty_methodInjection():void
		{
			var m:Composition = Composition(_i.getInstance(Composition));
			assertThat(m.methodInjection, notNullValue());
		}
		
		[Test]
		public function testProperty_propertyInjection():void
		{
			var m:Composition = Composition(_i.getInstance(Composition));
			assertThat(m.propertyInjection, notNullValue());
		}
		
		[Test]
		public function testProperty_accessorInjection():void
		{
			var m:Composition = Composition(_i.getInstance(Composition));
			assertThat(m.accessorInjection, notNullValue());
		}
	}
}