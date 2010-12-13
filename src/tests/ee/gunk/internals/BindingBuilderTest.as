package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IProvider;
	import ee.gunk.IScope;
	import ee.gunk.Scopes;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.Type;
	import ee.gunk.testClasses.annotations.Custom;
	import ee.gunk.testClasses.interfaces.I1;
	import ee.gunk.testClasses.interfaces.I2;
	import ee.gunk.testClasses.interfaces.I3;
	import ee.gunk.testClasses.interfaces.I4;
	import ee.gunk.testClasses.providers.TestProvider1;
	import ee.gunk.testClasses.providers.TestProvider2;
	import ee.gunk.testClasses.providers.TestProvider4;
	import ee.gunk.testClasses.scopes.TestScope;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	import ee.gunk.testClasses.types.TestType3;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	
	public class BindingBuilderTest
	{		
		private var _di:DependencyInjectorStub
		private var _ar:IAnnotationRegistry;
		private var _b:Vector.<IBinding>;
		
		[Before]
		public function setUp():void
		{
			_di = new DependencyInjectorStub();
			_ar = new AnnotationRegistryStub();
			_b = new Vector.<IBinding>();
		}
		
		[After]
		public function tearDown():void
		{
			_di = null;
			_ar = null;
			_b = null;
		}
		
		[Test]
		public function testBindingBuilder():void
		{
			new BindingBuilder(_b, _di, _ar, TestType1);
			assertThat(_b[0], notNullValue());
		}
		
		[Test]
		public function testBindingBuilder_untargetted():void
		{
			new BindingBuilder(_b, _di, _ar, TestType1);
			assertThat(_b[0], instanceOf(UntargetedBinding));
		}
		
		[Test]
		public function testBindingBuilder_untargettedSignature():void
		{
			new BindingBuilder(_b, _di, _ar, TestType1);
			assertThat(_b[0].key, notNullValue());
		}
		
		[Test]
		public function testBindingBuilder_untargettedType():void
		{
			new BindingBuilder(_b, _di, _ar, TestType1);
			var v:UntargetedBinding = UntargetedBinding(_b[0]);
			assertThat(v.type, equalTo(TestType1));
		}
		
		[Test]
		public function testBindingBuilder_implementedBy():void
		{
			new BindingBuilder(_b, _di, _ar, I1);
			assertThat(_b[0], instanceOf(ClassBinding));
		}
		
		[Test(expects="Error")]
		public function testBindingBuilder_unknownImplementedBy():void
		{
			new BindingBuilder(_b, _di, _ar, I3);
		}
		
		[Test]
		public function testBindingBuilder_implementedByType():void
		{
			new BindingBuilder(_b, _di, _ar, I1);
			var v:ClassBinding = ClassBinding(_b[0]);
			assertThat(v.type, equalTo(TestType1));
		}
		
		[Test]
		public function testBindingBuilder_providedBy():void
		{
			new BindingBuilder(_b, _di, _ar, I2);
			assertThat(_b[0], instanceOf(ProviderBinding));
		}
		
		[Test(expects="Error")]
		public function testBindingBuilder_unknownProvidedBy():void
		{
			new BindingBuilder(_b, _di, _ar, I4);
		}
		
		[Test]
		public function testBindingBuilder_singletonAnnotation():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType3);
			assertThat(_b[0], instanceOf(ScopedBinding));
		}
		
		[Test]
		public function testBindingBuilder_providedByType():void
		{
			new BindingBuilder(_b, _di, _ar, I2);
			var v:ProviderBinding = ProviderBinding(_b[0]);
			assertThat(v.type, equalTo(TestProvider2));
		}
		
		[Test]
		public function testAnnotatedWith_annotationType():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.annotatedWith(Type);
			assertThat(_b[0], instanceOf(AnnotatedBinding));
		}
		
		[Test]
		public function testAnnotatedWith_annotationType_annotations():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.annotatedWith(Type);
			var b:AnnotatedBinding = AnnotatedBinding(_b[0]);
			assertThat(b.annotations, notNullValue());
		}		
		
		[Test]
		public function testAnnotatedWith_annotationInstance():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.annotatedWith(new Type(null));
			assertThat(_b[0], instanceOf(AnnotatedBinding));
		}
		
		[Test]
		public function testAnnotatedWith_annotationTypeArray():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.annotatedWith([Type, Custom]);
			assertThat(_b[0], instanceOf(AnnotatedBinding));
		}
		
		[Test]
		public function testAnnotatedWith_annotationTypeVector():void
		{
			var v:Vector.<Class> = new Vector.<Class>();
			v.push(Type);
			v.push(Custom);
			
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.annotatedWith(v);
			assertThat(_b[0], instanceOf(AnnotatedBinding));
		}
		
		[Test]
		public function testAnnotatedWith_annotationInstanceArray():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.annotatedWith([new Type(null), new Custom()]);
			assertThat(_b[0], instanceOf(AnnotatedBinding));
		}
		
		[Test]
		public function testAnnotatedWith_annotationInstanceVector():void
		{
			var v:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			v.push(new Type(null));
			v.push(new Custom());
			
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.annotatedWith(v);
			assertThat(_b[0], instanceOf(AnnotatedBinding));
		}
		
		[Test]
		public function testTo():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.to(TestType1);
			assertThat(_b[0], instanceOf(ClassBinding));
		}
		
		[Test]
		public function testTo_type():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.to(TestType2);
			var b:ClassBinding = ClassBinding(_b[0]);
			assertThat(b.type, equalTo(TestType2));
		}
		
		[Test]
		public function testTo_singletonAnnotation():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType3);
			bb.to(TestType3);
			assertThat(_b[0], instanceOf(ScopedBinding));
		}
		
		[Test]
		public function testToInstance():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.toInstance(new TestType1());
			assertThat(_b[0], instanceOf(InstanceBinding));
		}
		
		[Test]
		public function testToInstance_instance():void
		{
			var i:Object = new TestType1();
			
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.toInstance(i);
			var b:InstanceBinding = InstanceBinding(_b[0]);
			assertThat(b.instance, equalTo(i));
		}
		
		[Test]
		public function testToProvider():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.toProvider(TestProvider1);
			assertThat(_b[0], instanceOf(ProviderBinding));
		}
		
		[Test]
		public function testToProvider_type():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.toProvider(TestProvider1);
			var b:ProviderBinding = ProviderBinding(_b[0]);
			assertThat(b.type, equalTo(TestProvider1));
		}
		
		[Test]
		public function testToProvider_singletonAnnotation():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.toProvider(TestProvider4);
			assertThat(_b[0], instanceOf(ScopedBinding));
		}		
		
		[Test]
		public function testToProviderInstance():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.toProviderInstance(new TestProvider1());
			assertThat(_b[0], instanceOf(ProviderInstanceBinding));
		}
		
		[Test]
		public function testToProviderInstance_instance():void
		{
			var i:IProvider = new TestProvider1();
			
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.toProviderInstance(i);
			var b:ProviderInstanceBinding = ProviderInstanceBinding(_b[0]);
			assertThat(b.provider, equalTo(i));
		}
		
		[Test]
		public function testAsSingleton():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.to(TestType1);
			bb.asSingleton();
			assertThat(_b[0], instanceOf(ScopedBinding));
		}
		
		[Test]
		public function testAsSingleton_scope():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.to(TestType1);
			bb.asSingleton();
			
			var b:ScopedBinding = ScopedBinding(_b[0]);
			assertThat(b.scope, equalTo(Scopes.SINGLETON));
		}
		
		[Test]
		public function testInScope():void
		{
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.to(TestType1);
			bb.inScope(new TestScope());
			assertThat(_b[0], instanceOf(ScopedBinding));
		}
		
		[Test]
		public function testInScope_scope():void
		{
			var s:TestScope = new TestScope();
			
			var bb:BindingBuilder = new BindingBuilder(_b, _di, _ar, TestType1);
			bb.to(TestType1);
			bb.inScope(s);
			
			var b:ScopedBinding = ScopedBinding(_b[0]);
			assertThat(b.scope, equalTo(s));
		}
	}
}