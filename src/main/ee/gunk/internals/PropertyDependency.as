package ee.gunk.internals
{
	import ee.gunk.IKey;

	/**
	 * @private
	 */
	internal final class PropertyDependency extends NamedDependecy
	{
		private var _dependency:IKey;
		
		public function PropertyDependency(name:String, dependency:IKey)
		{
			super(name);
			_dependency = dependency;
		}
		
		public function get dependency():IKey
		{
			return _dependency;
		}
	}
}