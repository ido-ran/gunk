package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IKeyAwareProvider;
	import ee.gunk.IProvider;

	/**
	 * @private
	 */
	internal final class ClassProvider implements IProvider, IInternalFactory
	{
		private var _type:Class;
		private var _dependencyInjector:IDependencyInjector;
		
		public function ClassProvider(dependencyInjector:IDependencyInjector, type:Class)
		{
			_dependencyInjector = dependencyInjector;
			_type = type;
		}
		
		private function _get(context:ConstructionContext = null):Object
		{
			try
			{
				return _dependencyInjector.createInstance(_type, context);
			} catch (e:Error)
			{
				throw new Error("There was a problem instantiating '" + _type + "', make " +
					"sure the constructor is annotated with [Inject], has no arguments or has a " +
					"specific provider bound.\n" +
					"Original message: " + e.message + "\n" +
					"Stacktrace: \n" + 
					e.getStackTrace());
				
			}
			
			//unreachable
			return null;
		}
		
		public function get():Object
		{
			return _get();
		}
		
		public function createInstance(context:ConstructionContext):Object
		{
			return _get(context);
		}
	}
}