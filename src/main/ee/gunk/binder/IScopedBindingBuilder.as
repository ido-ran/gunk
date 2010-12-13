package ee.gunk.binder
{
	import ee.gunk.IScope;

	public interface IScopedBindingBuilder
	{
		function inScope(scope:IScope):void;
		function asSingleton():void;
	}
}