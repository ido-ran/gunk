package ee.gunk
{
	/**
	 * A special type of provider that is 'key aware'. This means 
	 * that it will be given the key for the specific dependency. 
	 * This allows providers to use information of the specific dependencies 
	 * when providing instances.
	 * <p />
	 * A clear example of this is the DynamicProvider
	 * 
	 * @see ee.gunk.provider.DynamicProvider
	 */
	public interface IKeyAwareProvider extends IProvider
	{
		/**
		 * Returns an instance for the given key
		 * 
		 * @param key	The dependency that an instance is requested for
		 */
		function getFor(key:IKey):Object
	}
}