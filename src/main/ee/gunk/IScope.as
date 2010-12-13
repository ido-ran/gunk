package ee.gunk
{
	/**
	 * Specifies a scope. A scope can be used to get control over the amount of 
	 * instances that will be created.
	 * 
	 * @see #scope()
	 * @see ee.gunk.Singleton
	 */
	public interface IScope
	{
		/**
		 * Instructs the scope to provide a provider using the given arguments.
		 * 
		 * @param key		The key for which this scope is created. Note that this 
		 * 					is the key of the binding and not the key of the dependency.
		 * 					If you want the scope provider to be aware of the dependency 
		 * 					key you need it to implement IKeyAwareProvider.
		 * @param provider	The provider that would be used if no scope was applied
		 * 
		 * @return A provider controlling the creation of instances
		 * 
		 * @see ee.gunk.IKeyAwareProvider
		 */
		function scope(key:IKey, provider:IProvider):IProvider;
		
		/**
		 * A string representation of the scope
		 */
		function toString():String;
	}
}