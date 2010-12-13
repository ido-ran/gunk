package ee.gunk.binder
{
	import ee.gunk.IProvider;
	
	/**
	 * The binding builder to created linked bindings
	 * 
	 * @see ee.gunk.IBinder
	 */
	public interface ILinkedBindingBuilder extends IScopedBindingBuilder
	{
		/**
		 * Binds to a class
		 */
		function to(type:Class):IScopedBindingBuilder;
		
		/**
		 * Binds to an instance
		 */
		function toInstance(instance:Object):void;
		
		/**
		 * Binds to a provider (where Gunk manages it's construction
		 */
		function toProvider(type:Class):IScopedBindingBuilder;
		
		/**
		 * Binds to a provider instance
		 */
		function toProviderInstance(instance:IProvider):IScopedBindingBuilder;
	}
}