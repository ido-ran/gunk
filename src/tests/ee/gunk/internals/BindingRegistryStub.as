package ee.gunk.internals
{
	import ee.gunk.IProvider;
	import ee.gunk.IKey;
	import ee.gunk.IBinding;
	import ee.gunk.testClasses.bindings.TestBinding1;
	
	public class BindingRegistryStub implements IBindingRegistry
	{
		private var _lastBinding:IBinding;
		
		public function BindingRegistryStub()
		{
		}
		
		public function addBinding(binding:IBinding):void
		{
			_lastBinding = binding;
		}
		
		public function hasBinding(key:IKey):Boolean
		{
			return true;
		}
		
		public function getBinding(key:IKey):IBinding
		{
			return new TestBinding1(key, null);
		}
		
		public function get lastBinding():IBinding
		{
			return _lastBinding;
		}
	}
}