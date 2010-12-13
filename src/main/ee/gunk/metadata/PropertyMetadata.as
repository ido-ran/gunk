package ee.gunk.metadata
{
	import ee.gunk.util.StringUtil;
	
	import flash.utils.getQualifiedClassName;

	public class PropertyMetadata extends TypeMetadata
	{
		private var _name:String;
		
		public function PropertyMetadata(annotations:Vector.<AnnotationMetadata>, type:Class, name:String)
		{
			super(annotations, type);
			
			_name = name;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		override public function toString():String
		{
			var s:String = annotations ? StringUtil.forEach(annotations, "\n") + "\n" : "";
			s += "var " + name + ":" + getQualifiedClassName(type);
			
			return s;
		}
	}
}