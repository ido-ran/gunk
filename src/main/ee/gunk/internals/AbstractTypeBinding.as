package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IProvider;
	import ee.gunk.util.assertAbstract;
	
	/**
	 * @private
	 */
	internal class AbstractTypeBinding extends AbstractBinding
	{
		private var _type:Class;
		
		public function AbstractTypeBinding(provider:IProvider, key:IKey, type:Class)
		{
			assertAbstract(this, AbstractTypeBinding);
			
			_type = type;
			
			super(provider, key);
			
		}
		
		public function get type():Class
		{
			return _type;
		}
	}
}