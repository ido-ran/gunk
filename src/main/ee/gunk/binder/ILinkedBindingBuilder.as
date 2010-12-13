package ee.gunk.binder
{
	import ee.gunk.IProvider;

	public interface ILinkedBindingBuilder extends IScopedBindingBuilder
	{
		function to(type:Class):IScopedBindingBuilder;
		function toInstance(instance:Object):void;
		function toProvider(type:Class):IScopedBindingBuilder;
		function toProviderInstance(instance:IProvider):IScopedBindingBuilder;
	}
}