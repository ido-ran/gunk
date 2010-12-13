package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.Key;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.metadata.MethodMetadata;
	import ee.gunk.testClasses.types.TestType1;
	
	import org.hamcrest.object.IsInstanceOfMatcher;
	
	public class DependencyFactoryStub implements IDependencyFactory
	{
		private var _dependencies:ClassDependencies;
		
		public function DependencyFactoryStub(dependencies:ClassDependencies = null)
		{
			_dependencies = dependencies;
		}
		
		public function createDependency(type:Class, annotations:Vector.<IAnnotation>):IKey
		{
			return new Key(type, annotations);
		}
		
		public function createClassDependencies(object:Object):ClassDependencies
		{
			return _dependencies;
		}
		
		public function createMethodDependencies(methodMetadata:MethodMetadata, requiredInject:Boolean = true):MethodDependencies
		{
			var arguments:Vector.<IKey> = new Vector.<IKey>();
			arguments.push(new Key(TestType1, null));
			
			return new MethodDependencies("getTestType", arguments);
		}
		
		static public function get combined():ClassDependencies
		{
			//class dependencies for Combined
			var arguments:Vector.<IKey> = new Vector.<IKey>();
			arguments.push(new Key(TestType1, null));
			
			var constructor:MethodDependencies = new MethodDependencies(null, arguments);
			
			var property:PropertyDependency;
			var properties:Vector.<PropertyDependency> = new Vector.<PropertyDependency>();
			property = new PropertyDependency("property1", new Key(TestType1, null));
			properties.push(property);
			property = new PropertyDependency("accessor1", new Key(TestType1, null));
			properties.push(property);
			
			var methods:Vector.<MethodDependencies> = new Vector.<MethodDependencies>();
			var method:MethodDependencies = new MethodDependencies("method1", arguments);
			methods.push(method);
			
			return new ClassDependencies(constructor, properties, methods);
		}
	}
}