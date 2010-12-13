package ee.gunk.metadata
{
	import by.blooddy.crypto.MD5;
	
	import ee.gunk.util.IHashObject;
	import ee.gunk.util.IMap;

	public class AnnotationMetadata implements IHashObject
	{
		private var _name:String;
		private var _defaultValue:String;
		private var _values:IMap;
		
		private var _hash:String;
		
		public function AnnotationMetadata(name:String, defaultValue:String, values:IMap)
		{
			_name = name;
			_defaultValue = defaultValue;
			_values = values;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get defaultValue():String
		{
			return _defaultValue;
		}
		
		public function get values():IMap
		{
			return _values;
		}
		
		public function get hash():String
		{
			if (!_hash)
			{
				_hash = MD5.hash(_name + _defaultValue + (values == null ? "" : values.hash));
			}
			
			return _hash;
		}
		
		public function toString():String
		{
			var s:String = "[" + name;
			
			if (defaultValue || values)
			{
				s += "(";
				
				var i:uint;
				
				if (defaultValue)
				{
					s += "\"" + defaultValue + "\"";
					i++;
				}
				
				if (values)
				{
					var key:Object;
					var keys:Vector.<Object> = values.keys;
					for each (key in keys)
					{
						if (i)
						{
							s += ", ";
						}
						
						s += key + "=\"" + values.get(key) + "\"";
						i++;
					}
				}
				
				s += ")";
			}
			
			s += "]";
			
			return s;
		}
	}
}