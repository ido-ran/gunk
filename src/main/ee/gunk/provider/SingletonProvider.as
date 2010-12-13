package ee.gunk.provider
{
	import ee.gunk.IKey;
	import ee.gunk.IKeyAwareProvider;
	import ee.gunk.IProvider;
	
	/**
	 * A provider for singletons. Instances are created lazy (on first request) 
	 */
	public class SingletonProvider implements IProvider, IKeyAwareProvider
	{
		private var _creator:IProvider;
		private var _instance:Object;
		
		/**
		 * Constructs a new singleton provider
		 * 
		 * @param creator	The provider used to obtain the instance
		 */
		public function SingletonProvider(creator:IProvider)
		{
			_creator = creator;
		}
		
		private function _getInstance(key:IKey = null):Object
		{
			if (!_instance)
			{
				if (key && _creator is IKeyAwareProvider)
				{
					_instance = IKeyAwareProvider(_creator).getFor(key);
				} else
				{
					_instance = _creator.get();
				}
			}
			return _instance;
		}
		
		public function get():Object
		{
			return _getInstance();
		}
		
		public function getFor(key:IKey):Object
		{
			return _getInstance(key);
		}
	}
}