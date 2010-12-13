package ee.gunk.annotation
{
	import by.blooddy.crypto.MD5;
	
	import ee.gunk.util.IMap;
	import ee.gunk.util.assertAbstract;
	
	import flash.utils.getQualifiedClassName;

	/**
	 * Base class that can be used for annotations
	 * 
	 * Note: this is an abstract class and can not be instantiated
	 */
	public class AbstractAnnotation implements IAnnotation
	{
		private var _values:IMap;
		private var _defaultValue:String	;
		private var _annotationName:String;
		
		private var _hash:String;
		
		public function AbstractAnnotation(defaultValue:String, values:IMap)
		{
			assertAbstract(this, AbstractAnnotation);
			
			_defaultValue = defaultValue;
			_values = values;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get defaultValue():String
		{
			return _defaultValue;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get values():IMap
		{
			return _values;
		}
		
		/**
		 * Name of the annotation. This is automatically derived from the class name using:
		 * <code>getQualifiedClassName(this).split("::")[1]</code>
		 */
		public function get annotationName():String
		{
			if (!_annotationName)
			{
				_annotationName = getQualifiedClassName(this).split("::")[1];
			}
			
			return _annotationName;
		}
		
		/**
		 * Provides an MD5 hash using the annotationName, defaultValue and values.hash
		 */
		public function get hash():String
		{
			if (!_hash)
			{
				_hash = MD5.hash(annotationName + defaultValue + (values == null ? "" : values.hash));
			}
			
			return _hash;
		}
		
		/**
		 * Returns a string representation of this annotation
		 */
		public function toString():String
		{
			var s:String = "[" + annotationName;
			
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