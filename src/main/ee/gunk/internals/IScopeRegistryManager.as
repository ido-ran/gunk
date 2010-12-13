package ee.gunk.internals
{
	import ee.gunk.IScope;
	import ee.gunk.util.IMap;

	public interface IScopeRegistryManager
	{
		function getScopeRegistry(scope:IScope):IMap;
	}
}