package ee.gunk.internals
{
	import ee.gunk.IKey;

	public interface IDependencyInjector
	{
		function createInstance(type:Class, context:ConstructionContext = null):Object;
		function injectDependencies(instance:Object):void;
		function callMethodWithDependencies(method:Function, argumentDependencies:Vector.<IKey>):Object;
	}
}