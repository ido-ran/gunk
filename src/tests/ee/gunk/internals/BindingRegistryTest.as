package ee.gunk.internals
{
	import ee.gunk.IProvider;
	import ee.gunk.IKey;
	import ee.gunk.Key;
	import ee.gunk.IBinding;
	import ee.gunk.testClasses.annotations.Custom;
	import ee.gunk.testClasses.bindings.TestBinding1;
	import ee.gunk.testClasses.providers.TestProvider1;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;

	public class BindingRegistryTest
	{	
		private var _br:BindingRegistry;
		private var _s:IKey;
		private var _p:IProvider;
		
		[Before]
		public function setUp():void
		{
			_br = new BindingRegistry();
			_s = new Key(TestType1, null);
			_p = new TestProvider1();
		}
		
		[After]
		public function tearDown():void
		{
			_br = null;
			_s = null;
			_p = null;
		}
		
		[Test]
		public function testAddBinding():void
		{
			_br.addBinding(new TestBinding1(_s, _p));
		}
		
		[Test(expects="Error")]
		public function testSetBindingAt_error():void
		{
			_br.addBinding(new TestBinding1(_s, _p));
			_br.addBinding(new TestBinding1(_s, _p));
		}
		
		[Test]
		public function testHasBinding_false():void
		{
			var b:Boolean = _br.hasBinding(_s);
			assertThat(b, equalTo(false));
		}
		
		[Test]
		public function testHasBinding_true():void
		{
			_br.addBinding(new TestBinding1(_s, _p));
			var b:Boolean = _br.hasBinding(_s);
			assertThat(b, equalTo(true));
		}
		
		[Test]
		public function testGetBinding_null():void
		{
			var b:IBinding = _br.getBinding(_s);
			assertThat(b, nullValue());
		}
		
		[Test]
		public function testGetBinding():void
		{
			_br.addBinding(new TestBinding1(_s, _p))
			var b:IBinding = _br.getBinding(_s);
			assertThat(b, notNullValue());
		}
	}
}