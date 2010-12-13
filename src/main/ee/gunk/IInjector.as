package ee.gunk
{
	/**
	 * This is the component of Gunk that provides the dependency injection.
	 * <p />
	 * Creates the following bindings internally:
	 * <ul>
	 * 	<li>An instance of itself</li>
	 * 	<li>IProvider to DynamicProvider</li>
	 * </ul>
	 * 
	 * @see ee.gunk.DynamicProvider
	 */
	public interface IInjector
	{
		/**
		 * Injects dependencies (property, accessor and method dependencies) on the given object.
		 */
		function injectDependencies(object:Object):void;
		
		/**
		 * Returns an instance of the given type.
		 * <p />
		 * Internally calls getProvider(type).get()
		 */
		function getInstance(type:Class):Object;
		
		/**
		 * Returns the provider for the given type.
		 * <p />
		 * Internally calls getProviderFor(new Key(type))
		 */
		function getProvider(type:Class):IProvider;
		
		/**
		 * Returns the provider for the given key as bound by a binding. If no explicit 
		 * binding was found it will try to create it using the given key.
		 */
		function getProviderFor(key:IKey):IProvider;
	}
}