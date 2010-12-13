package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IProvider;
	
	internal final class MethodProvider implements IProvider
	{
		private var _dependencyInjector:IDependencyInjector;
		private var _method:Function;
		private var _argumentDependencies:Vector.<IKey>;
		
		public function MethodProvider(dependencyInjector:IDependencyInjector, method:Function, argumentDependencies:Vector.<IKey>)
		{
			_dependencyInjector = dependencyInjector;
			_method = method;
			_argumentDependencies = argumentDependencies;
		}
		
		public function get():Object
		{
			return _dependencyInjector.callMethodWithDependencies(_method, _argumentDependencies);
		}
	}
}