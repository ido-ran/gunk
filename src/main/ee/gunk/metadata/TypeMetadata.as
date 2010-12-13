package ee.gunk.metadata
{
	import ee.gunk.util.StringUtil;
	
	import flash.utils.getQualifiedClassName;

	public class TypeMetadata extends Metadata
	{
		private var _type:Class;
		
		public function TypeMetadata(annotations:Vector.<AnnotationMetadata>, type:Class)
		{
			super(annotations);
			_type = type;
		}
		
		public function get type():Class
		{
			return _type;
		}
		
		public function toString():String
		{
			var s:String = annotations ? StringUtil.forEach(annotations, " ") + " " : "";
			s += getQualifiedClassName(type);
			
			return s; 
		}
	}
}