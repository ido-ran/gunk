package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IKey;
	import ee.gunk.IProvider;

	/**
	 * @private
	 */
	internal final class ProviderInstanceBinding extends AbstractBinding
	{
		public function ProviderInstanceBinding(base:IBinding, provider:IProvider)
		{
			super(provider, base.key);
		}
	}
}