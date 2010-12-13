package ee.gunk.internals
{
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.Type;
	import ee.gunk.metadata.AnnotationMetadata;
	import ee.gunk.testClasses.annotations.Custom;
	import ee.gunk.testClasses.annotations.Custom2;
	import ee.gunk.testClasses.annotations.Custom2Factory;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.util.IMap;
	import ee.gunk.util.ObjectMap;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	
	public class AnnotationRegistryTest
	{		
		private var _ar:AnnotationRegistry;
		
		[Before]
		public function setUp():void
		{
			_ar = new AnnotationRegistry();
		}
		
		[After]
		public function tearDown():void
		{
			_ar = null;
		}
		
		[Test]
		public function testRegisterAnnotationType():void
		{
			_ar.registerAnnotationType(Type);
		}

		[Test(expects="Error")]
		public function testRegisterAnnotationType_error():void
		{
			_ar.registerAnnotationType(TestType1);
		}
		
		[Test]
		public function testGetAnnotation():void
		{
			var a:IAnnotation = _ar.getAnnotation(new AnnotationMetadata(null, null, null));
			assertThat(a, nullValue());
		}
		
		[Test]
		public function testGetAnnotation_unknown():void
		{
			var a:IAnnotation = _ar.getAnnotation(new AnnotationMetadata("Type", null, null));
			assertThat(a, nullValue());
		}
		
		[Test]
		public function testGetAnnotation_type():void
		{
			_ar.registerAnnotationType(Type);
			var a:IAnnotation = _ar.getAnnotation(new AnnotationMetadata("Type", null, null));
			assertThat(a, instanceOf(Type));
		}
		
		[Test]
		public function testGetAnnotation_annotationName():void
		{
			_ar.registerAnnotationType(Type);
			var a:IAnnotation = _ar.getAnnotation(new AnnotationMetadata("Type", null, null));
			assertThat(a.annotationName, equalTo("Type"));
		}
		
		[Test]
		public function testGetAnnotation_defaultValue():void
		{
			_ar.registerAnnotationType(Type);
			var a:IAnnotation = _ar.getAnnotation(new AnnotationMetadata("Type", "defaultValue", null));
			assertThat(a.defaultValue, equalTo("defaultValue"));
		}
		
		[Test]
		public function testGetAnnotation_values():void
		{
			_ar.registerAnnotationType(Custom);
			var values:IMap = new ObjectMap();
			var a:IAnnotation = _ar.getAnnotation(new AnnotationMetadata("Custom", "defaultValue", values));
			assertThat(a.values, equalTo(values));
		}
		
		[Test]
		public function testRegisterAnnotationFactory():void
		{
			_ar.registerAnnotationFactory(Custom2, new Custom2Factory());
		}
		
		[Test]
		public function testCreateInstance():void
		{
			var a:IAnnotation = _ar.createInstance(Custom);
			assertThat(a, notNullValue());
		}
		
		[Test]
		public function testCreateInstance_type():void
		{
			var a:IAnnotation = _ar.createInstance(Custom);
			assertThat(a, instanceOf(Custom));
		}
		
		[Test]
		public function testCreateInstance_defaultValueNull():void
		{
			var a:IAnnotation = _ar.createInstance(Custom);
			assertThat(a.defaultValue, nullValue());
		}
		
		[Test]
		public function testCreateInstance_valuesNull():void
		{
			var a:IAnnotation = _ar.createInstance(Custom);
			assertThat(a.values, nullValue());
		}
		
		[Test(expects="Error")]
		public function testCreateInstance_error():void
		{
			_ar.createInstance(Custom2);
		}
		
		[Test]
		public function testCreateInstance_usingFactory():void
		{
			_ar.registerAnnotationFactory(Custom2, new Custom2Factory());
			var a:IAnnotation = _ar.createInstance(Custom2);
			assertThat(a, notNullValue());
		}
	}
}