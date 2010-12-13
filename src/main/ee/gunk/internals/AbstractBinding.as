package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IKey;
	import ee.gunk.IProvider;
	
	import flash.utils.getQualifiedClassName;

	/**
	 * @private
	 */
	internal class AbstractBinding implements IBinding
	{
		private var _provider:IProvider;
		private var _key:IKey;
		
		public function AbstractBinding(provider:IProvider, key:IKey)
		{
			_provider = provider;
			_key = key;
		}
		
		public function get key():IKey
		{
			return _key;
		}
		
		public function get provider():IProvider
		{
			return _provider;
		}
		
		public function toString():String
		{
			var name:String = getQualifiedClassName(this).split("::")[1];
			
			return "[" + name + " " + key + "]";
		}
	}
}