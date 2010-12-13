package ee.gunk.binder
{
	import ee.gunk.IScope;

	/**
	 * The binding builder to scoped bindings
	 * 
	 * @see ee.gunk.IBinder
	 */
	public interface IScopedBindingBuilder
	{
		/**
		 * Makes sure instances are created in the given scope
		 */
		function inScope(scope:IScope):void;
		
		/**
		 * Makes sure instances are created using the Singleton scope
		 * <p />
		 * Internally calls <code>inScope(Scopes.SINGLETON)</code>
		 */
		function asSingleton():void;
	}
}