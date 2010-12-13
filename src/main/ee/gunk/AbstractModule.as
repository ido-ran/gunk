package ee.gunk
{
	import ee.gunk.binder.IAnnotatedBindingBuilder;
	import ee.gunk.binder.ILinkedBindingBuilder;
	import ee.gunk.util.assertAbstract;

	/**
	 * Basic implementation of a module.
	 * <p />
	 * Subclasses should override the <code>configure()</code> method.
	 * <p />
	 * It mirrors methods found on the IBinder.
	 * 
	 * @see ee.gunk.IBinder
	 */
	public class AbstractModule implements IModule
	{
		protected var binder:IBinder;
		
		public function AbstractModule()
		{
			assertAbstract(this, AbstractModule);
		}
		
		/**
		 * @inheritDoc
		 */
		public function configureWithBinder(binder:IBinder):void
		{
			this.binder = binder;
			configure();
			binder = null;
		}
		
		/**
		 * @see ee.gunk.IBinder#bind()
		 */
		protected function bind(type:Class):IAnnotatedBindingBuilder
		{
			return binder.bind(type);
		}
		
		/**
		 * @see ee.gunk.IBinder#bindKey()
		 */
		protected function bindKey(key:IKey):ILinkedBindingBuilder
		{
			return binder.bindKey(key);
		}
		
		/**
		 * @see ee.gunk.IBinder#install()
		 */
		protected function install(module:IModule):void
		{
			binder.install(module);
		}
		
		/**
		 * Override this method and create bindings
		 */
		protected function configure():void
		{
			throw new Error("Method should be implemented by sub class");
		}		
	}
}