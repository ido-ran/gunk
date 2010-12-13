package ee.gunk.metadata
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	
	public class AnnotationMetadataBuilderTest
	{
		private var _amb:AnnotationMetadataBuilder;
		
		[Before]
		public function setUp():void
		{
			_amb = new AnnotationMetadataBuilder();
		}
		
		[After]
		public function tearDown():void
		{
			_amb = null;
		}
		
		[Test]
		public function testBuild_empty():void
		{
			var metadata:XML = <metadata name="Name" />;
			
			var am:AnnotationMetadata = _amb.build(metadata);
			assertThat(am.name, equalTo("Name"));
		}
		
		[Test]
		public function testBuild_defaultValue():void
		{
			var metadata:XML = 
			<metadata name="Name">
				<arg key="" value="defaultValue" />
			</metadata>;
			
			var am:AnnotationMetadata = _amb.build(metadata);
			assertThat(am.defaultValue, equalTo("defaultValue"));
		}		
		
		[Test]
		public function testBuild_singleKey():void
		{
			var metadata:XML = 
			<metadata name="Name">
				<arg key="key1" value="value1" />
			</metadata>;
			
			var am:AnnotationMetadata = _amb.build(metadata);
			assertThat(am.values.keys, notNullValue());
			assertThat(am.values.keys.length, equalTo(1));
		}
		
		[Test]
		public function testBuild_multipleKey():void
		{
			var metadata:XML = 
			<metadata name="Name">
				<arg key="key1" value="value1" />
				<arg key="key2" value="value2" />
			</metadata>;
			
			var am:AnnotationMetadata = _amb.build(metadata);
			assertThat(am.values.keys, notNullValue());
			assertThat(am.values.keys.length, equalTo(2));
		}		
		
		[Test]
		public function testBuild_values():void
		{
			var metadata:XML = 
				<metadata name="Name">
					<arg key="key1" value="value1" />
				</metadata>;
			
			var am:AnnotationMetadata = _amb.build(metadata);
			assertThat(am.values.keys[0], equalTo("key1"));
			assertThat(am.values.get("key1"), equalTo("value1"));
		}		
		
		[Test]
		public function testBuild_methodAnnotationMetadata():void
		{
			var metadata:XML = 
				<metadata name={AnnotationNames.ARGUMENTS}>
					<arg key="0" value="[Name]" />
				</metadata>;
			
			var am:AnnotationMetadata = _amb.build(metadata);
			assertThat(am, instanceOf(MethodAnnotationMetadata));
		}
		
		[Test]
		public function testBuild_methodAnnotationMetadata_missingArgument():void
		{
			var metadata:XML = 
				<metadata name={AnnotationNames.ARGUMENTS}>
					<arg key="1" value="[Name]" />
				</metadata>;
			
			var am:AnnotationMetadata = _amb.build(metadata);
			assertThat(am, instanceOf(MethodAnnotationMetadata));
		}
		
		[Test]
		public function testBuildFromString_single():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[Name]");
			assertThat(am.length, equalTo(1));
		}
		
		[Test]
		public function testBuildFromString_multiple():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[Name][Name]");
			assertThat(am.length, equalTo(2));
		}
		
		[Test]
		public function testBuildFromString_empty():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[Name]");
			assertThat(am[0].name, equalTo("Name"));
		}
		
		[Test]
		public function testBuildFromString_emptyWithWhiteSpace():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[  Name  ]");
			assertThat(am[0].name, equalTo("Name"));
		}
		
		[Test]
		public function testBuildFromString_defaultValue():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[Name('defaultValue')]");
			assertThat(am[0].defaultValue, equalTo("defaultValue"))
		}
		
		[Test]
		public function testBuildFromString_defaultValueWithWhiteSpace():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[  Name  (  'defaultValue'  )  ]");
			assertThat(am[0].defaultValue, equalTo("defaultValue"))
		}
		
		[Test]
		public function testBuildFromString_singleKey():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[Name(key1='value1')]");
			assertThat(am[0].values.keys, notNullValue());
			assertThat(am[0].values.keys.length, 1);
		}
		
		[Test]
		public function testBuildFromString_singleKeyWithWhiteSpace():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[  Name  (  key1  =  'value1'  )  ]");
			assertThat(am[0].values.keys, notNullValue());
			assertThat(am[0].values.keys.length, 1);
		}
		
		[Test]
		public function testBuildFromString_multipleKey():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[Name(key1='value1',key2='value2')]");
			assertThat(am[0].values.keys, notNullValue());
			assertThat(am[0].values.keys.length, 2);			
		}
		
		[Test]
		public function testBuildFromString_multipleKeyWithWhiteSpace():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[  Name  (  key1  =  'value1'  ,  key2  =  'value2'  )  ]");
			assertThat(am[0].values.keys, notNullValue());
			assertThat(am[0].values.keys.length, 2);			
		}
		
		[Test]
		public function testBuildFromString_values():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[Name(key1='value1')]");
			assertThat(am[0].values.keys[0], equalTo("key1"));
			assertThat(am[0].values.get("key1"), equalTo("value1"));			
		}
		
		[Test]
		public function testBuildFromString_valuesWithWhiteSpace():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[  Name  (  key1  =  'value1')  )  ]");
			assertThat(am[0].values.keys[0], equalTo("key1"));
			assertThat(am[0].values.get("key1"), equalTo("value1"));			
		}
		
		[Test]
		public function testBuildFromString_multipleEntries():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("[Name][Name('defaultValue')][Name(key1='value1')][Name('defaultValue', key1='value1', key2='value2')]");
			assertThat(am.length, equalTo(4));
		}
		
		[Test]
		public function testBuildFromString_multipleEntriesWithWhiteSpace():void
		{
			var am:Vector.<AnnotationMetadata> = _amb.buildFromString("   [Name]   [Name('defaultValue')][Name(key1='value1')]   [Name('defaultValue', key1='value1', key2='value2')]");
			assertThat(am.length, equalTo(4));
		}
	}
}