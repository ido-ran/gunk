package ee.gunk
{
	/**
	 * Specifies a Gunk module
	 * 
	 * @see ee.gunk.AbstractModule
	 */
	public interface IModule
	{
		/**
		 * Allows the module to configure itself using the given binder
		 */
		function configureWithBinder(binder:IBinder):void;
	}
}