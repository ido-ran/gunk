package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IProvider;

	internal class InternalFactoryWrapper implements IProvider
	{
		private var _internalFactory:IInternalFactory;
		private var _instance:Object;
		private var _context:ConstructionContext;
		
		public function InternalFactoryWrapper(internalFactory:IInternalFactory)
		{
			_internalFactory = internalFactory;
		}
		
		public function get():Object
		{
			return new InternalFactoryWrapper(_internalFactory);
		}
		
		public function get instance():Object
		{
			//If we have an instance return it
			if (_instance)
			{
				return _instance;
			}
			
			var instance:Object;
			
			//If we have a context, check the context for the instance
			if (_context)
			{
				instance = _context.instance;
				if (instance)
				{
					return instance;
				}
			} else
			{
				_context = new ConstructionContext();
			}
			
			//Retrieve an instance using the context
			_instance = _internalFactory.createInstance(_context);
			
			return _instance;
		}
	}
}