package ee.gunk.features
{
	import ee.gunk.AbstractModule;
	import ee.gunk.Gunk;
	import ee.gunk.IInjector;
	import ee.gunk.testClasses.injectables.Circular1;
	import ee.gunk.testClasses.injectables.Circular2;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;

	public class CircularDependencyTest extends AbstractModule
	{
		private var _i:IInjector;
		
		[Before]
		public function setUp():void
		{
			_i = Gunk.createInjector(this);
		}
		
		[After]
		public function tearDown():void
		{
			_i = null;
		}
		
		protected override function configure():void
		{
			bind(Circular1).asSingleton();
			bind(Circular2).asSingleton();
		}
		
		[Test]
		public function testCircularInjection():void
		{
			var c1:Circular1 = Circular1(_i.getInstance(Circular1));
			assertThat(c1, notNullValue());
			assertThat(c1.circular2, notNullValue());
			assertThat(c1.circular2.circular1, equalTo(c1));
		}
	}
}