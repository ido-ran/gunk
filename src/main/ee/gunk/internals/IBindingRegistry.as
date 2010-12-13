package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IBinding;

	internal interface IBindingRegistry
	{
		function hasBinding(key:IKey):Boolean;
		function getBinding(key:IKey):IBinding;
		function addBinding(binding:IBinding):void;
	}
}