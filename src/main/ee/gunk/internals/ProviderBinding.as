package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IProvider;

	/**
	 * @private
	 */
	internal final class ProviderBinding extends AbstractTypeBinding
	{
		public function ProviderBinding(dependencyInjector:IDependencyInjector, base:IBinding, type:Class)
		{
			super(new ProviderProvider(dependencyInjector, type), base.key, type);
		}
	}
}