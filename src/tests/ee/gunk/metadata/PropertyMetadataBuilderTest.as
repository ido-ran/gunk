package ee.gunk.metadata
{
	import ee.gunk.testClasses.injectables.A;
	import ee.gunk.testClasses.injectables.NoAnnotation;
	import ee.gunk.testClasses.injectables.P;
	import ee.gunk.testClasses.types.TestType1;
	
	import flash.utils.describeType;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	
	public class PropertyMetadataBuilderTest
	{
		private var _pmb:PropertyMetadataBuilder;
		
		[Before]
		public function setUp():void
		{
			var amb:AnnotationMetadataBuilderStub = new AnnotationMetadataBuilderStub();
			_pmb = new PropertyMetadataBuilder(amb);
		}
		
		[After]
		public function tearDown():void
		{
			_pmb = null;
		}
		
		private function _propertySort(prop1:PropertyMetadata, prop2:PropertyMetadata):Number
		{
			if (prop1.name < prop2.name)
			{
				return -1;
			} else if (prop1.name > prop2.name)
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
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(NoAnnotation));
			assertThat(pm, nullValue());
		}		
		
		[Test]
		public function testBuild_properties():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(P));
			assertThat(pm, notNullValue());
			assertThat(pm.length, equalTo(8));
		}
		
		[Test]
		public function testBuild_propertiesType():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(P));
			pm.sort(_propertySort);
			assertThat(pm[0].type, notNullValue());
			assertThat(pm[0].type, equalTo(TestType1));
		}
		
		[Test]
		public function testBuild_propertiesName():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(P));
			pm.sort(_propertySort);
			assertThat(pm[0].name, notNullValue());
			assertThat(pm[0].name, equalTo("property1"));
		}
		
		[Test]
		public function testBuild_propertiesSingleAnnotation():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(P));
			pm.sort(_propertySort);
			assertThat(pm[0].annotations, notNullValue());
			assertThat(pm[0].annotations.length, equalTo(1));
		}
		
		[Test]
		public function testBuild_propertiesMultipleAnnotation():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(P));
			pm.sort(_propertySort);
			assertThat(pm[1].annotations, notNullValue());
			assertThat(pm[1].annotations.length, equalTo(2));
		}
		
		[Test]
		public function testBuild_accessors():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(A));
			assertThat(pm, notNullValue());
			assertThat(pm.length, equalTo(7));
		}
		
		[Test]
		public function testBuild_accessorsType():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(A));
			pm.sort(_propertySort);
			assertThat(pm[0].type, notNullValue());
			assertThat(pm[0].type, equalTo(TestType1));
		}
		
		[Test]
		public function testBuild_accessorsName():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(A));
			pm.sort(_propertySort);
			assertThat(pm[0].name, notNullValue());
			assertThat(pm[0].name, equalTo("accessor1"));
		}
		
		[Test]
		public function testBuild_accessorsSingleAnnotation():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(A));
			pm.sort(_propertySort);
			assertThat(pm[0].annotations, notNullValue());
			assertThat(pm[0].annotations.length, equalTo(1));
		}
		
		[Test]
		public function testBuild_accessorsMultipleAnnotation():void
		{
			var pm:Vector.<PropertyMetadata> = _pmb.build(describeType(A));
			pm.sort(_propertySort);
			assertThat(pm[1].annotations, notNullValue());
			assertThat(pm[1].annotations.length, equalTo(2));
		}

	}
}