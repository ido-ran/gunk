package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IProvider;

	/**
	 * @private
	 */
	internal final class InstanceBinding extends AbstractBinding
	{
		private var _instance:Object;
		
		public function InstanceBinding(dependencyInjector:IDependencyInjector, base:IBinding, instance:Object)
		{
			_instance = instance;
			
			super(new InstanceProvider(dependencyInjector, instance), base.key);
		}
		
		public function get instance():Object
		{
			return _instance;
		}
	}
}