package ee.gunk
{
	/**
	 * Specifies a provider
	 */
	public interface IProvider
	{
		/**
		 * Constructs a new instance
		 */
		function get():Object;
	}
}