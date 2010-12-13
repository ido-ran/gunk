package ee.gunk.metadata
{
	import ee.gunk.testClasses.injectables.Combined;
	import ee.gunk.testClasses.injectables.NoAnnotation;
	import ee.gunk.testClasses.interfaces.I1;
	
	import flash.utils.getQualifiedClassName;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	
	public class ClassMetadataFactoryTest
	{
		private var _mf:IClassMetadataFactory;
		
		[Before]
		public function setUp():void
		{
			_mf = new ClassMetadataFactory();
		}
		
		[After]
		public function tearDown():void
		{
			_mf = null;
		}
		
		private function _classSort(class1:Class, class2:Class):Number
		{
			var name1:String = getQualifiedClassName(class1);
			var name2:String = getQualifiedClassName(class2);
			
			if (name1 < name2)
			{
				return -1;
			} else if (name1 > name2)
			{
				return 1;
			} else
			{
				return 0;
			}
		}
		
		[Test]
		public function testGetClassMetadata_noAnnotations():void
		{
			var cm:ClassMetadata = _mf.getClassMetadata(NoAnnotation);
			assertThat(cm, nullValue());
		}
		
		[Test]
		public function testGetClassMetadata():void
		{
			var cm:ClassMetadata = _mf.getClassMetadata(Combined);
			assertThat(cm, notNullValue());
		}
		
		[Test]
		public function testGetClassMetadata_annotations():void
		{
			var cm:ClassMetadata = _mf.getClassMetadata(Combined);
			assertThat(cm.annotations, notNullValue());
			assertThat(cm.annotations.length, equalTo(1));
		}
		
		[Test]
		public function testGetClassMetadata_interfaceAnnotations():void
		{
			var cm:ClassMetadata = _mf.getClassMetadata(I1);
			assertThat(cm.annotations, notNullValue());
			assertThat(cm.annotations.length, equalTo(1));
		}
		
		[Test]
		public function testGetClassMetadata_constructor():void
		{
			var cm:ClassMetadata = _mf.getClassMetadata(Combined);
			assertThat(cm.constructor, notNullValue());
		}
		
		[Test]
		public function testGetClassMetadata_implementedTypes():void
		{
			var cm:ClassMetadata = _mf.getClassMetadata(Combined);
			assertThat(cm.implementedTypes, notNullValue());
		}
		
		[Test]
		public function testGetClassMetadata_methods():void
		{
			var cm:ClassMetadata = _mf.getClassMetadata(Combined);
			assertThat(cm.methods, notNullValue());
			assertThat(cm.methods.length, equalTo(1));
		}
		
		[Test]
		public function testGetClassMetadata_properties():void
		{
			var cm:ClassMetadata = _mf.getClassMetadata(Combined);
			assertThat(cm.properties, notNullValue());
			assertThat(cm.properties.length, equalTo(2));
		}
		
		[Test]
		public function testGetClassMetadata_type():void
		{
			var cm:ClassMetadata = _mf.getClassMetadata(Combined);
			assertThat(cm.type, notNullValue());
			assertThat(cm.type, equalTo(Combined));
		}
	}
}