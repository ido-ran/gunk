package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.Key;
	import ee.gunk.testClasses.injectables.Combined;
	import ee.gunk.testClasses.providers.TestProvider1;
	import ee.gunk.testClasses.providers.TestProvider3;
	import ee.gunk.testClasses.types.TestType1;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	
	
	public class DependencyInjectorTest
	{		
		private var _di:IDependencyInjector;
		
		[Before]
		public function setUp():void
		{
			_di = new DependencyInjector(new InjectorStub(new TestProvider1()), new DependencyFactoryStub(DependencyFactoryStub.combined));
		}
		
		[After]
		public function tearDown():void
		{
			_di = null;
		}
		
		[Test]
		public function testCreateInstance():void
		{
			_di.createInstance(Combined);
		}
		
		[Test]
		public function testCreateInstance_keyAwareProvider():void
		{
			var di:DependencyInjector = new DependencyInjector(new InjectorStub(new TestProvider3()), new DependencyFactoryStub(DependencyFactoryStub.combined));
			
			di.createInstance(Combined);
		}
		
		[Test]
		public function testCreateInstance_type():void
		{
			var o:Object = _di.createInstance(Combined);
			assertThat(o, instanceOf(Combined));
		}
		
		[Test]
		public function testCreateInstance_cArgument1():void
		{
			var o:Combined = Combined(_di.createInstance(Combined));
			assertThat(o.cArgument, notNullValue());
		}
		
		[Test]
		public function testCreateInstance_property1():void
		{
			var o:Combined = Combined(_di.createInstance(Combined));
			_di.injectDependencies(o);
			assertThat(o.property1, notNullValue());
		}
		
		[Test]
		public function testCreateInstance_accessor1():void
		{
			var o:Combined = Combined(_di.createInstance(Combined));
			_di.injectDependencies(o);
			assertThat(o.accessor1, notNullValue());
		}
		
		[Test]
		public function testCreateInstance_m1Argument1():void
		{
			var o:Combined = Combined(_di.createInstance(Combined));
			_di.injectDependencies(o);
			assertThat(o.m1Argument1, notNullValue());
		}
		
		[Test]
		public function testCallMethodWithDependencies():void
		{
			var ad:Vector.<IKey> = new Vector.<IKey>();
			ad.push(new Key(TestType1, null));
			
			var o:Object = _di.callMethodWithDependencies(_methodWithDependencies, ad);
			
			assertThat(o, notNullValue());
		}
		
		private function _methodWithDependencies(testType:TestType1):TestType1
		{
			return testType;
		}
	}
}