package ee.gunk.internals
{
	

	/**
	 * @private
	 */
	internal final class ClassDependencies
	{
		private var _constructorDependencies:MethodDependencies;
		private var _propertyDependencies:Vector.<PropertyDependency>;
		private var _methodDependencies:Vector.<MethodDependencies>;
		
		public function ClassDependencies(constructDependencies:MethodDependencies, propertyDependencies:Vector.<PropertyDependency>, methodDependencies:Vector.<MethodDependencies>)
		{
			_constructorDependencies = constructDependencies;
			_propertyDependencies = propertyDependencies;
			_methodDependencies = methodDependencies;
		}
		
		public function get constructorDependencies():MethodDependencies
		{
			return _constructorDependencies;
		}
		
		public function get propertyDependencies():Vector.<PropertyDependency>
		{
			return _propertyDependencies;
		}
		
		public function get methodDependencies():Vector.<MethodDependencies>
		{
			return _methodDependencies;
		}
	}
}