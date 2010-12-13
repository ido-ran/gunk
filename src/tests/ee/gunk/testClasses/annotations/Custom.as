package ee.gunk.testClasses.annotations
{
	import by.blooddy.crypto.MD5;
	
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.util.IMap;

	public class Custom implements IAnnotation
	{
		private var _values:IMap;
		private var _defaultValue:String;
		private var _annotationName:String;
		
		private var _hash:String;
		
		public function Custom(defaultValue:String = null, values:IMap = null)
		{
			_defaultValue = defaultValue;
			_values = values;
			_annotationName = "Custom";
		}
		
		public function get defaultValue():String
		{
			return _defaultValue;
		}
		
		public function set defaultValue(defaultValue:String):void
		{
			_defaultValue = defaultValue;
		}
		
		public function get values():IMap
		{
			return _values;
		}
		
		public function set values(values:IMap):void
		{
			_values = values;
		}
		
		public function get annotationName():String
		{
			return _annotationName;
		}
		
		public function get hash():String
		{
			if (!_hash)
			{
				_hash = MD5.hash(annotationName + defaultValue + (values == null ? "" : values.hash));
			}
			
			return _hash;
		}
	}
}