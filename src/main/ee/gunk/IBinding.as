package ee.gunk
{
	/**
	 * Defines a binding. 
	 */ 
	public interface IBinding
	{
		/**
		 * The key (or signature) of the binding
		 */
		function get key():IKey;
		
		/**
		 * The provider that provides instances for this binding
		 */
		function get provider():IProvider;
	}
}