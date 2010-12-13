package ee.gunk.util
{
	import flash.utils.flash_proxy;

	[RemoteClass(alias="ee.di.util.ObjectMap")]
	public class ObjectMap extends AbstractMap
	{
		public function ObjectMap(obj:Object = null)
		{
			super();
			
			if (obj)
			{
				var s:String;
				for (s in obj)
				{
					put(s, obj[s]);
				}
			}
		}
		
		override protected function createStore():Object
		{
			return new Object();
		}
	}
}