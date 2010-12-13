package ee.gunk.testClasses.injectables
{
	public class NoAnnotation
	{
		private var _accessor1:Object;
		private var _mArgument1:Object;
		private var _cArgument1:Object;
		
		public function NoAnnotation(cArgument1:Object)
		{
		}
		
		public var prop1:Object;
		
		public function get accessor1():Object
		{
			return _accessor1;
		}
		
		public function set accessor1(value:Object):void
		{
			_accessor1 = value;
		}
		
		public function method1(mArgument1:Object):void
		{
			_mArgument1 = mArgument1;
		}
		
		public function get mArgument1():Object
		{
			return _mArgument1;
		}
	}
}