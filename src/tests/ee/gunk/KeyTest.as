package ee.gunk
{
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.Type;
	import ee.gunk.testClasses.annotations.Custom;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	
	import org.flexunit.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	
	public class KeyTest
	{		
		[Test(expects="Error")]
		public function testKey():void
		{
			new Key(null);
		}
		
		[Test]
		public function testGetType():void
		{
			var s1:Key = new Key(TestType1);
			assertThat(s1.type, equalTo(TestType1));
		}
		
		[Test]
		public function testGetAnnotations():void
		{
			var s1:Key = new Key(TestType1, new Vector.<IAnnotation>());
			assertThat(s1.annotations, notNullValue());
		}
		
		[Test]
		public function testGetHash():void
		{
			var s1:Key = new Key(TestType1);
			assertThat(s1.hash, notNullValue());
		}
		
		[Test]
		public function testKey_hashTypeEqual():void
		{
			var s1:Key = new Key(TestType1);
			var s2:Key = new Key(TestType1);
			
			assertThat(s1.hash, equalTo(s2.hash));
		}
		
		[Test]
		public function testKey_hashTypeNotEqual():void
		{
			var s1:Key = new Key(TestType1);
			var s2:Key = new Key(TestType2);
			
			assertThat(s1.hash, not(equalTo(s2.hash)));
		}
		
		[Test]
		public function testKey_hashAnnotationsEqual():void
		{
			var a1:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			a1.push(new Type("ee.di.testClasses.injectables.types.TestType1"));
			
			var a2:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			a2.push(new Type("ee.di.testClasses.injectables.types.TestType2"));
			
			var s1:Key = new Key(TestType1, a1);
			var s2:Key = new Key(TestType1, a2);
			
			assertThat(s1.hash, equalTo(s2.hash));
		}
		
		[Test]
		public function testKey_hashAnnotationsNotEqual():void
		{
			var a1:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			a1.push(new Type("ee.di.testClasses.injectables.types.TestType1"));
			
			var a2:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			a2.push(new Custom());
			
			var s1:Key = new Key(TestType1, a1);
			var s2:Key = new Key(TestType1, a2);
			
			assertThat(s1.hash, not(equalTo(s2.hash)));
		}
		
		[Test]
		public function testKey_fullHashTypeEqual():void
		{
			var d1:Key = new Key(TestType1);	
			var d2:Key = new Key(TestType1);
			
			assertThat(d1.fullHash, equalTo(d2.fullHash));
		}
		
		[Test]
		public function testKey_fullHashTypeNotEqual():void
		{
			var d1:Key = new Key(TestType1);	
			var d2:Key = new Key(TestType2);
			
			assertThat(d1.fullHash, not(equalTo(d2.fullHash)));
		}
		
		[Test]
		public function testKey_fullHashAnnotationsEqual():void
		{
			var a1:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			a1.push(new Type("ee.di.testClasses.injectables.types.TestType1"));
			
			var a2:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			a2.push(new Type("ee.di.testClasses.injectables.types.TestType1"));
			
			var d1:Key = new Key(TestType1, a1);
			var d2:Key = new Key(TestType1, a2);
			
			assertThat(d1.fullHash, equalTo(d2.fullHash));
		}
		
		[Test]
		public function testKey_fullHashAnnotationsNotEqual():void
		{
			var a1:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			a1.push(new Type("ee.di.testClasses.injectables.types.TestType1"));
			
			var a2:Vector.<IAnnotation> = new Vector.<IAnnotation>();
			a2.push(new Type("ee.di.testClasses.injectables.types.TestType2"));
			
			var d1:Key = new Key(TestType1, a1);
			var d2:Key = new Key(TestType1, a2);
			
			assertThat(d1.fullHash, not(equalTo(d2.fullHash)));
		}		
	}
}