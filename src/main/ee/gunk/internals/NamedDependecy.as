package ee.gunk.internals
{
	/**
	 * @private
	 */
	internal class NamedDependecy
	{
		private var _name:String;
		
		public function NamedDependecy(name:String)
		{
			_name = name;
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}