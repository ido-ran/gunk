package ee.gunk.annotation
{
	import ee.gunk.Key;
	import ee.gunk.IBinder;

	/**
	 * Utility methods for Named annotation.
	 * 
	 * @see Named
	 */
	public class Names
	{
		/**
		 * Creates a new <code>[Named("name")]</code> annotation
		 */
		static public function named(name:String):Named
		{
			return new Named(name);
		}
		
		/**
		 * Binds String annotated with <code>[Named("{key}")]</code> to instance 
		 * <code>{value}</code> for each key-value pair in the given object.
		 * 
		 * @param binder	The binder to use when creating the bindings
		 * @param object	The object containing name-value pairs
		 */
		static public function bindProperties(binder:IBinder, object:Object):void
		{
			var name:String;
			
			for (name in object)
			{
				binder.bindKey(Key.get(String, new Named(name))).toInstance(object[name]);
			}
		}
	}
}