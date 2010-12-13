package ee.gunk.internals
{
	import ee.gunk.IProvider;
	import ee.gunk.Key;

	/**
	 * @private
	 */
	internal final class UntargetedBinding extends AbstractTypeBinding
	{
		public function UntargetedBinding(dependencyInjector:IDependencyInjector, type:Class)
		{
			super(new ClassProvider(dependencyInjector, type), new Key(type), type);
		}
	}
}