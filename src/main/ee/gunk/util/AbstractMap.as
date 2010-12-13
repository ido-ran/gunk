package ee.gunk.util
{
	import by.blooddy.crypto.MD5;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	/**
	 * @private
	 */
	internal class AbstractMap implements IMap, IExternalizable
	{
		protected var store:Object;
		private var _keys:Vector.<Object>;
		private var _hash:String;
		
		public function AbstractMap()
		{
			assertAbstract(this, AbstractMap);
			
			store = createStore();
			_keys = new Vector.<Object>();
		}
		
		protected function createStore():Object
		{
			throw new Error("Method should be implemented by sub class");
		}
		
		public function put(key:Object, value:Object):void
		{
			store[key] = value;
			
			_keys.push(key);
			
			_hash = null;
		}
		
		public function get(key:Object):Object
		{
			return store[key];
		}
		
		public function containsKey(key:Object):Boolean
		{
			return store.hasOwnProperty(key);
		}
		
		public function remove(key:Object):Object
		{
			var object:Object = get(key);
			delete store[key];
			
			var index:int = _keys.indexOf(object);
			_keys.splice(index, 1);			
			
			_hash = null;
			
			return object;
		}
		
		public function readExternal(input:IDataInput):void
		{
			store = input.readObject();
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeObject(store);
		}
		
		public function get keys():Vector.<Object>
		{
			return _keys;
		}
		
		public function get hash():String
		{
			if (!_hash)
			{
				var s:String = "";
				
				var i:uint;
				var current:Object;
				
				for (i = 0; i < _keys.length; i++)
				{
					current = _keys[i];
					s += _getString(current);
					current = store[current];
					s += _getString(current);
				}
				
				_hash = MD5.hash(s);
			}
			
			return _hash;
		}
		
		private function _getString(obj:Object):String
		{
			var s:String = "";
			
			if (obj is IHashObject)
			{
				s += IHashObject(obj).hash;
			} else
			{
				s += obj.toString();
			}
			
			return s;
		}
			
	}
}