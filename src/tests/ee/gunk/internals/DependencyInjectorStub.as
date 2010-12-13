package ee.gunk.internals
{
	import ee.gunk.IKey;

	public class DependencyInjectorStub implements IDependencyInjector
	{
		private var _injectDependenciesCalled:Boolean;
		
		public function createInstance(type:Class, context:ConstructionContext = null):Object
		{
			return {};
		}

		public function injectDependencies(instance:Object):void
		{
			_injectDependenciesCalled = true;
		}
		
		public function get injectDependenciesCalled():Boolean
		{
			return _injectDependenciesCalled;
		}
		
		public function callMethodWithDependencies(method:Function, argumentDependencies:Vector.<IKey>):Object
		{
			return method.apply(null, null);
		}
	}
}