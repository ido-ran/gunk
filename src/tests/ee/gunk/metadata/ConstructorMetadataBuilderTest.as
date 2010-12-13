package ee.gunk.metadata
{
	import ee.gunk.testClasses.injectables.C1;
	import ee.gunk.testClasses.injectables.C2;
	import ee.gunk.testClasses.injectables.C4;
	import ee.gunk.testClasses.injectables.NoAnnotation;
	import ee.gunk.testClasses.types.TestType1;
	
	import flash.utils.describeType;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	
	public class ConstructorMetadataBuilderTest
	{	
		private var _cmb:ConstructorMetadataBuilder;
		private var _amb:AnnotationMetadataBuilderStub;
		
		[Before]
		public function setUp():void
		{
			_amb = new AnnotationMetadataBuilderStub();
			_cmb = new ConstructorMetadataBuilder(_amb);
		}
		
		[After]
		public function tearDown():void
		{
			_amb = null;
			_cmb = null;
		}
		
		[Test]
		public function testBuild_noAnnotations():void
		{
			var mm:MethodMetadata = _cmb.build(describeType(NoAnnotation), NoAnnotation);
			assertThat(mm, nullValue());
		}
		
		[Test]
		public function testBuild():void
		{
			var mm:MethodMetadata = _cmb.build(describeType(C1), C1);
			assertThat(mm, notNullValue());
		}
		
		[Test]
		public function testBuild_annotations():void
		{
			_amb.defaultValue = true;
			var mm:MethodMetadata = _cmb.build(describeType(C1), C1);
			assertThat(mm.annotations, notNullValue());
		}		
		
		[Test]
		public function testBuild_arguments():void
		{
			var mm:MethodMetadata = _cmb.build(describeType(C1), C1);
			assertThat(mm.arguments, notNullValue());
		}
		
		[Test]
		public function testBuild_name():void
		{
			var mm:MethodMetadata = _cmb.build(describeType(C1), C1);
			assertThat(mm.name, nullValue());
		}

		[Test]
		public function testBuild_type():void
		{
			var mm:MethodMetadata = _cmb.build(describeType(C1), C1);
			assertThat(mm.type, nullValue());
		}

		[Test]
		public function testBuild_annotatedConstructor():void
		{
			_amb.defaultValue = true;
			var mm:MethodMetadata = _cmb.build(describeType(C1), C1);
			assertThat(mm.annotations.length, equalTo(1));
		}

		[Test]
		public function testBuild_singleArgument():void
		{
			var mm:MethodMetadata = _cmb.build(describeType(C1), C1);
			assertThat(mm.arguments.length, equalTo(1));
		}
		
		[Test]
		public function testBuild_argument():void
		{
			var mm:MethodMetadata = _cmb.build(describeType(C1), C1);
			assertThat(mm.arguments[0], notNullValue());
		}
		
		[Test]
		public function testBuild_argumentType():void
		{
			var mm:MethodMetadata = _cmb.build(describeType(C1), C1);
			assertThat(mm.arguments[0].type, equalTo(TestType1));
		}
		
		[Test]
		public function testBuild_multipleArgument():void
		{
			var mm:MethodMetadata = _cmb.build(describeType(C2), C2);
			assertThat(mm.arguments.length, equalTo(2));
		}
		
		public function testBuild_multipleAnnotatedConstructorArgument():void
		{
			_amb.methodAnnotation = 1;
			var mm:MethodMetadata = _cmb.build(describeType(C4), C4);
			
			assertThat(mm.arguments[1].annotations, notNullValue());
		}
	}
}