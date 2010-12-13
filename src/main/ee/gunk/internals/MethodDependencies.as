package ee.gunk.internals
{
	import ee.gunk.IKey;

	/**
	 * @private
	 */
	internal final class MethodDependencies extends NamedDependecy
	{
		private var _argumentDependencies:Vector.<IKey>;
		
		public function MethodDependencies(name:String, argumentDependencies:Vector.<IKey>)
		{
			super(name);
			_argumentDependencies = argumentDependencies;
		}
		
		public function get argumentDependencies():Vector.<IKey>
		{
			return _argumentDependencies;
		}
	}
}