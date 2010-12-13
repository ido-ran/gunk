package ee.gunk.metadata
{
	import ee.gunk.util.StringUtil;
	
	import flash.utils.getQualifiedClassName;

	public class MethodMetadata extends TypeMetadata
	{
		private var _name:String; 
		private var _arguments:Vector.<TypeMetadata>;
		
		public function MethodMetadata(annotations:Vector.<AnnotationMetadata>, returnType:Class, name:String, methodArguments:Vector.<TypeMetadata>)
		{
			super(annotations, returnType);
			_name = name;
			_arguments = methodArguments;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get arguments():Vector.<TypeMetadata>
		{
			return _arguments;
		}
		
		override public function toString():String
		{
			var s:String = annotations ? StringUtil.forEach(annotations, "\n") + "\n" : "";
			s += "function " + name + "(" + (this.arguments ? StringUtil.forEach(this.arguments, ", ") : "") + "):" + getQualifiedClassName(type);
			return s;
		}
	}
}