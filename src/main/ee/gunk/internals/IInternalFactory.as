package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IKeyAwareProvider;
	
	/**
	 * @private
	 */
	internal interface IInternalFactory
	{
		function createInstance(context:ConstructionContext):Object
	}
}