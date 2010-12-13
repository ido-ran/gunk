package ee.gunk.util
{
	import flash.utils.IExternalizable;

	public interface IMap extends IHashObject
	{
		function get(key:Object):Object;
		function put(key:Object, value:Object):void;
		function containsKey(key:Object):Boolean;
		function remove(key:Object):Object;
		function get keys():Vector.<Object>;
	}
}