package ee.gunk
{
	import by.blooddy.crypto.MD5;
	
	import ee.gunk.annotation.IAnnotation;
	
	import flash.utils.getQualifiedClassName;

	/**
	 * Default implementation of the IKey interface
	 */
	public class Key implements IKey
	{
		/**
		 * Utility method to create a key with one annotation
		 */
		static public function get(type:Class, annotation:IAnnotation):IKey
		{
			var annotations:Vector.<IAnnotation> = new Vector.<IAnnotation>(1);
			annotations[0] = annotation;
			
			return new Key(type, annotations);
		}
		
		private var _type:Class;
		private var _annotations:Vector.<IAnnotation>;
		private var _hash:String;
		private var _fullHash:String;
		
		/**
		 * Constructs a new key, will throw an error if the given type is null
		 */
		public function Key(type:Class, annotations:Vector.<IAnnotation> = null)
		{
			if (!type)
			{
				throw new Error("type can not be null");
			}
			
			_type = type;
			
			_annotations = annotations;
			
			if (_annotations)
			{
				_annotations.sort(_sortAnnotations);
			}
		}
		
		private function _sortAnnotations(annotation1:IAnnotation, annotation2:IAnnotation):Number
		{
			if (annotation1.annotationName < annotation2.annotationName)
			{
				return -1;
			} else if (annotation1.annotationName > annotation2.annotationName)
			{
				return 1;
			} else
			{
				return 0;
			}
		}
		
		/**
		 * The type of the key
		 */
		public function get type():Class
		{
			return _type;
		}
		
		/**
		 * The annotations of the key. They should be considered read only as they 
		 * are sorted in the constructor.
		 */ 
		public function get annotations():Vector.<IAnnotation>
		{
			return _annotations;
		}
		
		/**
		 * The hash of this key. It's created and cached on first request.
		 * <p />
		 * The hash is created using the qualified type name and all annotation names.
		 */
		public function get hash():String
		{
			if (!_hash)
			{
				var s:String = getQualifiedClassName(_type);
				
				if (_annotations)
				{
					var annotation:IAnnotation;
					
					for each (annotation in _annotations)
					{
						s += annotation.annotationName;
					}
				}
				
				_hash = MD5.hash(s);
			}
			
			return _hash;
		}
		
		/**
		 * The full hash of this key. It's created and cached on first request.
		 * <p />
		 * The hash is created using the qualified type name and all annotation hashes.
		 */
		public function get fullHash():String
		{
			if (!_fullHash)
			{
				var s:String = getQualifiedClassName(type);
				
				if (annotations)
				{
					var annotation:IAnnotation;
					
					for each (annotation in annotations)
					{
						s += annotation.hash;
					}
				}
				
				_fullHash = MD5.hash(s);
			}
			
			return _fullHash;
		}
		
		/**
		 * Returns a string representation of this key.
		 */
		public function toString():String
		{
			return "{Key " + getQualifiedClassName(type) + (annotations ? " with " + annotations.toString() : "") + "}";
		}
	}
}