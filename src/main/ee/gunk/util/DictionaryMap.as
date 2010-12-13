package ee.gunk.util
{
	import flash.utils.Dictionary;

	public class DictionaryMap extends AbstractMap
	{
		public function DictionaryMap()
		{
		}
		
		override protected function createStore():Object
		{
			return new Dictionary();
		}
		
		override public function containsKey(key:Object):Boolean
		{
			return Boolean(store[key] !== undefined);
		}
	}
}