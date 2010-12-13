package ee.gunk.internals
{
	import ee.gunk.metadata.AnnotationMetadata;
	import ee.gunk.metadata.ClassMetadata;
	import ee.gunk.metadata.IClassMetadataFactory;
	import ee.gunk.metadata.MethodMetadata;
	import ee.gunk.metadata.PropertyMetadata;
	import ee.gunk.metadata.TypeMetadata;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	
	public class ClassMetadataFactoryStub implements IClassMetadataFactory
	{
		public var noMetadata:Boolean;
		
		public function ClassMetadataFactoryStub()
		{
		}
		
		public function getClassMetadata(object:Object):ClassMetadata
		{
			if (noMetadata)
			{
				return null;
			}
			
			var annotations:Vector.<AnnotationMetadata>;
			var arguments:Vector.<TypeMetadata>;
			
			//constructor
			annotations = new Vector.<AnnotationMetadata>();
			annotations.push(new AnnotationMetadata("Custom", null, null));
			arguments = new Vector.<TypeMetadata>();
			arguments.push(new TypeMetadata(annotations, TestType1));
			annotations = new Vector.<AnnotationMetadata>();
			annotations.push(new AnnotationMetadata("Inject", null, null));
			var constructor:MethodMetadata = new MethodMetadata(annotations, null, null, arguments);
			
			//properties
			var properties:Vector.<PropertyMetadata> = new Vector.<PropertyMetadata>();
			annotations = new Vector.<AnnotationMetadata>();
			annotations.push(new AnnotationMetadata("Inject", null, null));
			properties.push(new PropertyMetadata(annotations, TestType1, "property1"));
			annotations = new Vector.<AnnotationMetadata>();
			annotations.push(new AnnotationMetadata("Inject", null, null));
			annotations.push(new AnnotationMetadata("Custom", null, null));
			properties.push(new PropertyMetadata(annotations, TestType2, "property2"));
			
			//methods
			var methods:Vector.<MethodMetadata> = new Vector.<MethodMetadata>();
			annotations = new Vector.<AnnotationMetadata>();
			annotations.push(new AnnotationMetadata("Provides", null, null));
			methods.push(new MethodMetadata(annotations, TestType1, "getTestType", null));
			arguments = new Vector.<TypeMetadata>();
			arguments.push(new TypeMetadata(null, TestType1));
			annotations = new Vector.<AnnotationMetadata>();
			annotations.push(new AnnotationMetadata("Inject", null, null));
			methods.push(new MethodMetadata(annotations, null, "method1", arguments));
			arguments = new Vector.<TypeMetadata>();
			arguments.push(new TypeMetadata(null, TestType1));
			arguments.push(new TypeMetadata(null, TestType1));
			annotations = new Vector.<AnnotationMetadata>();
			annotations.push(new AnnotationMetadata("Inject", null, null));
			methods.push(new MethodMetadata(annotations, null, "method2", arguments));
			
			return new ClassMetadata(null, null, null, constructor, properties, methods);
		}
	}
}