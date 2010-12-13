package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IProvider;

	/**
	 * @private
	 */
	internal final class ClassBinding extends AbstractTypeBinding
	{
		public function ClassBinding(dependencyInjector:IDependencyInjector, base:IBinding, type:Class)
		{
			super(new ClassProvider(dependencyInjector, type), base.key, type);
		}
	}
}