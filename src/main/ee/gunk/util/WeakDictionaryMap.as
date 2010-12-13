package ee.gunk.util
{
	import flash.utils.Dictionary;

	public class WeakDictionaryMap extends DictionaryMap
	{
		public function WeakDictionaryMap()
		{
		}
		
		override protected function createStore():Object
		{
			return new Dictionary(true);
		}		
	}
}