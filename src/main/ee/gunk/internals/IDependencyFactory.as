package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.metadata.MethodMetadata;

	internal interface IDependencyFactory
	{
		function createDependency(type:Class, annotations:Vector.<IAnnotation>):IKey;
		function createClassDependencies(object:Object):ClassDependencies;
		function createMethodDependencies(methodMetadata:MethodMetadata, requiresInjectAnnotation:Boolean = true):MethodDependencies;
	}
}