package ee.gunk.metadata
{
	import ee.gunk.testClasses.injectables.M;
	import ee.gunk.testClasses.injectables.NoAnnotation;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	
	import flash.utils.describeType;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;

	public class MethodMetadataBuilderTest
	{
		private var _amb:AnnotationMetadataBuilderStub;
		private var _mmb:MethodMetadataBuilder;
		
		[Before]
		public function setUp():void
		{
			_amb = new AnnotationMetadataBuilderStub();
			_mmb = new MethodMetadataBuilder(_amb);
		}
		
		[After]
		public function tearDown():void
		{
			_mmb = null;
			_amb = null;
		}

		private function _methodSort(method1:MethodMetadata, method2:MethodMetadata):Number
		{
			if (method1.name < method2.name)
			{
				return -1;
			} else if (method1.name > method2.name)
			{
				return 1;
			} else
			{
				return 0;
			}
		}
		
		[Test]
		public function testBuild_noAnnotations():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(NoAnnotation));
			assertThat(mm, nullValue());
		}		
		
		[Test]
		public function testBuild():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			assertThat(mm, notNullValue());
			assertThat(mm.length, equalTo(8));
		}
		
		[Test]
		public function testBuild_typeNull():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[0].type, nullValue());
		}
		
		[Test]
		public function testBuild_typeNotNull():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[7].type, notNullValue());
			assertThat(mm[7].type, equalTo(TestType2));
		}
		
		[Test]
		public function testBuild_name():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[0].name, notNullValue());
			assertThat(mm[0].name, "method1");
		}
		
		[Test]
		public function testBuild_singleArgument():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[0].arguments, notNullValue());
			assertThat(mm[0].arguments.length, equalTo(1));
		}
		
		[Test]
		public function testBuild_multipleArguments():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[1].arguments, notNullValue());
			assertThat(mm[1].arguments.length, equalTo(2));
		}
		
		[Test]
		public function testBuild_singleAnnotation():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[0].annotations, notNullValue());
			assertThat(mm[0].annotations.length, equalTo(1));
		}
		
		[Test]
		public function testBuild_multipleAnnotations():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[2].annotations, notNullValue());
			assertThat(mm[2].annotations.length, equalTo(2));
		}
		
		[Test]
		public function testBuild_argumentType():void
		{
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[0].arguments[0].type, equalTo(TestType1));
		}
		
		[Test]
		public function testBuild_singleArgumentAnnotation():void
		{
			_amb.methodAnnotation = 1;
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[4].arguments[0].annotations, notNullValue());
		}
		
		[Test]
		public function testBuild_multipleArgumentAnnotation():void
		{
			_amb.methodAnnotation = 2;
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[3].arguments[1].annotations, notNullValue());
		}
		
		[Test]
		public function testBuild_multipleArgumentAnnotation_null():void
		{
			_amb.methodAnnotation = 1;
			var mm:Vector.<MethodMetadata> = _mmb.build(describeType(M));
			mm.sort(_methodSort);
			assertThat(mm[2].arguments[1].annotations, nullValue());
		}
	}
}