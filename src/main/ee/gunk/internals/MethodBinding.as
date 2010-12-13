package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IProvider;
	import ee.gunk.annotation.Type;
	
	/**
	 * @private
	 */
	internal final class MethodBinding extends AbstractBinding
	{
		private var _method:Function;
		private var _argumentDependencies:Vector.<IKey>;
		
		public function MethodBinding(dependencyInjector:IDependencyInjector, key:IKey, method:Function, argumentDependencies:Vector.<IKey>)
		{
			_method = method;
			_argumentDependencies = argumentDependencies;
			
			super(new MethodProvider(dependencyInjector, _method, _argumentDependencies), key);
		}
		
		public function get method():Function
		{
			return _method;
		}
		
		public function get argumentDependencies():Vector.<IKey>
		{
			return _argumentDependencies;
		}
	}
}