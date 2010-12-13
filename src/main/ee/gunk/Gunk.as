package ee.gunk
{
	import ee.gunk.internals.InjectorCreator;

	/**
	 * This is the main class of Gunk, create injectors using the static methods of this class.
	 */ 
	public class Gunk
	{
		static private const _privateObject:Object = {};
		static private const _instance:Gunk = new Gunk(_privateObject);
		
		/**
		 * Constructs a new injector using the given modules.
		 * 
		 * @param modules	Each module should implement the IModule interface
		 */
		static public function createInjector(... modules):IInjector
		{
			return _instance._injectorCreator.create(modules);
		}
		
		private var _injectorCreator:InjectorCreator;
		
		/**
		 * It is not possible to create an instance of Gunk
		 */
		public function Gunk(privateObject:Object)
		{
			if (privateObject != _privateObject)
			{
				throw new Error("Gunk can not be instantiated");
			}
			
			_injectorCreator = new InjectorCreator();
		}
	}
}