package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IKeyAwareProvider;

	internal interface IInternalFactory
	{
		function createInstance(context:ConstructionContext):Object
	}
}