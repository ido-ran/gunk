package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.testClasses.types.TestType1;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	
	public class DependencyFactoryTest
	{		
		private var _df:IDependencyFactory;
		private var _cmf:ClassMetadataFactoryStub;
		
		[Before]
		public function setUp():void
		{
			_cmf = new ClassMetadataFactoryStub();
			_df = new DependencyFactory(new AnnotationRegistryStub(), _cmf);
		}
		
		[After]
		public function tearDown():void
		{
			_df = null;
		}
		
		private function _propertySort(prop1:PropertyDependency, prop2:PropertyDependency):Number
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
		
		private function _methodSort(method1:MethodDependencies, method2:MethodDependencies):Number
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
		
		[Test(expects="Error")]
		public function testCreateDependency_error():void
		{
			_df.createDependency(null, null);
		}
		
		[Test]
		public function testCreateDependency():void
		{
			var d:IKey = _df.createDependency(TestType1, null);
			assertThat(d, notNullValue());
		}
		
		[Test]
		public function testCreateDependency_type():void
		{
			var d:IKey = _df.createDependency(TestType1, null);
			assertThat(d.type, notNullValue());
			assertThat(d.type, equalTo(TestType1));
		}
		
		[Test]
		public function testCreateDependency_annotations():void
		{
			var a:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			
			var d:IKey = _df.createDependency(TestType1, a);
			assertThat(d.annotations, notNullValue());
			assertThat(d.annotations, equalTo(a));
		}
		
		[Test]
		public function testCreateDependency_cache():void
		{
			var d1:IKey = _df.createDependency(TestType1, null);
			var d2:IKey = _df.createDependency(TestType1, null);
			assertThat(d1, equalTo(d2));
		}
		
		[Test]
		public function testCreateClassDependencies_noAnnotations():void
		{
			_cmf.noMetadata = true;
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d, nullValue());
		}
		
		[Test]
		public function testCreateClassDependencies():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d, notNullValue());
		}
		
		[Test]
		public function testCreateClassDependencies_constructorDependencies():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d.constructorDependencies, notNullValue());
		}
		
		[Test]
		public function testCreateClassDependencies_constructorDependencies_name():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d.constructorDependencies.name, nullValue());
		}
		
		[Test]
		public function testCreateClassDependencies_constructorDependencies_argumentDependencies():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d.constructorDependencies.argumentDependencies, notNullValue());
		}
		
		[Test]
		public function testCreateClassDependencies_constructorDependencies_singleArgumentDependency():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d.constructorDependencies.argumentDependencies.length, equalTo(1));
		}
		
		[Test]
		public function testCreateClassDependencies_constructorDependencies_argumentDependency_type():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d.constructorDependencies.argumentDependencies[0].type, notNullValue());
			assertThat(d.constructorDependencies.argumentDependencies[0].type, equalTo(TestType1));
		}
		
		[Test]
		public function testCreateClassDependencies_constructorDependencies_argumentDependency_annotations():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d.constructorDependencies.argumentDependencies[0].annotations, notNullValue());
			assertThat(d.constructorDependencies.argumentDependencies[0].annotations.length, equalTo(1));
		}
		
		[Test]
		public function testCreateClassDependencies_propertyDependencies():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d.propertyDependencies, notNullValue());
			assertThat(d.propertyDependencies.length, equalTo(2));
		}
		
		[Test]
		public function testCreateClassDependencies_propertyDependencies_name():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			d.propertyDependencies.sort(_propertySort);
			assertThat(d.propertyDependencies[0].name, equalTo("property1"));
		}
		
		[Test]
		public function testCreateClassDependencies_propertyDependencies_dependency():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			d.propertyDependencies.sort(_propertySort);
			assertThat(d.propertyDependencies[0].dependency, notNullValue());
		}
		
		[Test]
		public function testCreateClassDependencies_propertyDependencies_dependency_type():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			d.propertyDependencies.sort(_propertySort);
			assertThat(d.propertyDependencies[0].dependency.type, notNullValue());
			assertThat(d.propertyDependencies[0].dependency.type, equalTo(TestType1));
		}
		
		[Test]
		public function testCreateClassDependencies_propertyDependencies_dependency_annotations():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			d.propertyDependencies.sort(_propertySort);
			assertThat(d.propertyDependencies[1].dependency.annotations, notNullValue());
			assertThat(d.propertyDependencies[1].dependency.annotations.length, equalTo(1));
		}
		
		[Test]
		public function testCreateClassDependencies_methodDependencies():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			assertThat(d.methodDependencies, notNullValue());
			assertThat(d.methodDependencies.length, equalTo(2));
		}
		
		[Test]
		public function testCreateClassDependencies_methodDependencies_name():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			d.methodDependencies.sort(_methodSort);
			assertThat(d.methodDependencies[0].name, notNullValue());
			assertThat(d.methodDependencies[0].name, equalTo("method1"));
		}
		
		
		[Test]
		public function testCreateClassDependencies_methodDependencies_multipleArgumentDependency():void
		{
			var d:ClassDependencies = _df.createClassDependencies(Object);
			d.methodDependencies.sort(_methodSort);
			assertThat(d.methodDependencies[1].argumentDependencies.length, equalTo(2));
		}
	}
}