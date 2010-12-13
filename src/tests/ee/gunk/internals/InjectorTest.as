package ee.gunk.internals
{
	import ee.gunk.IProvider;
	import ee.gunk.Key;
	import ee.gunk.metadata.ClassMetadataFactory;
	import ee.gunk.testClasses.modules.TestModule;
	import ee.gunk.testClasses.types.TestType1;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.notNullValue;
	
	public class InjectorTest
	{		
		private var _ar:AnnotationRegistryStub;
		private var _cmf:ClassMetadataFactory;
		private var _m:Array;
		private var _tm:TestModule;
		
		[Before]
		public function setUp():void
		{
			_ar = new AnnotationRegistryStub();
			_cmf = new ClassMetadataFactory();
			_tm = new TestModule();
			_m = [_tm];
		}
		
		[After]
		public function tearDown():void
		{
			_ar = null;
			_cmf = null;
			_tm = null;
			_m = null;
		}
		
		[Test]
		public function testInjector():void
		{
			new Injector(_ar, _cmf, _m);
			assertThat(_tm.binder, notNullValue());
		}
		
		[Test]
		public function testGetInstance():void
		{
			var i:Injector = new Injector(_ar, _cmf, _m);
			var o:Object = i.getInstance(TestType1);
			assertThat(o, notNullValue());
		}
		
		[Test]
		public function testGetProvider():void
		{
			var i:Injector = new Injector(_ar, _cmf, _m);
			var o:IProvider = i.getProvider(TestType1);
			assertThat(o, notNullValue());
		}
		
		[Test]
		public function testGetProviderFor():void
		{
			var i:Injector = new Injector(_ar, _cmf, _m);
			var o:IProvider = i.getProviderFor(new Key(TestType1, null));
			assertThat(o, notNullValue());
		}
		
		[Test]
		public function testInjectDependencies():void
		{
			var i:Injector = new Injector(_ar, _cmf, _m);
			i.injectDependencies(new TestType1());
		}
	}
}