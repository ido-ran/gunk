package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IProvider;
	import ee.gunk.Key;
	import ee.gunk.binder.IAnnotatedBindingBuilder;
	import ee.gunk.binder.ILinkedBindingBuilder;
	import ee.gunk.testClasses.annotations.Custom2;
	import ee.gunk.testClasses.annotations.Custom2Factory;
	import ee.gunk.testClasses.modules.TestModule;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	
	public class BinderTest
	{		
		private var _b:Binder;
		private var _ar:AnnotationRegistryStub;
		private var _di:DependencyInjectorStub;
		
		[Before]
		public function setUp():void
		{
			_ar = new AnnotationRegistryStub()
			_di = new DependencyInjectorStub();
			_b = new Binder(_di, _ar, new ClassMetadataFactoryStub(), new DependencyFactoryStub());
		}
		
		[After]
		public function tearDown():void
		{
			_ar = null;
			_b = null;
			_di = null;
		}
		
		[Test]
		public function testBind():void
		{
			var b:IAnnotatedBindingBuilder = _b.bind(TestType1);
			assertThat(b, notNullValue());
		}
		
		[Test]
		public function testBindSignature():void
		{
			var b:ILinkedBindingBuilder = _b.bindKey(new Key(TestType1));
			assertThat(b, notNullValue());
		}		
		
		[Test]
		public function testBindAnnotationFactory():void
		{
			_b.bindAnnotationFactory(Custom2, new Custom2Factory()); 
			assertThat(_ar.registerAnnotationFactoryCalled, equalTo(true));
		}
		
		[Test]
		public function testGetBinding():void
		{
			var b:IBinding = _b.getBinding(new Key(TestType1));
			
			assertThat(b, notNullValue());
		}
		
		[Test]
		public function testInstall():void
		{
			_b.install(new TestModule());
		}
		
	}
}