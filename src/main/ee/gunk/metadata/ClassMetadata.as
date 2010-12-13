package ee.gunk.metadata
{
	import ee.gunk.util.StringUtil;
	
	import flash.utils.getQualifiedClassName;

	public class ClassMetadata extends TypeMetadata
	{
		private var _constructor:MethodMetadata;
		private var _properties:Vector.<PropertyMetadata>;
		private var _methods:Vector.<MethodMetadata>;
		private var _implementedTypes:Vector.<Class>;
		
		public function ClassMetadata(annotations:Vector.<AnnotationMetadata>, type:Class, implementedTypes:Vector.<Class>, constructor:MethodMetadata, properties:Vector.<PropertyMetadata>, methods:Vector.<MethodMetadata>)
		{
			super(annotations, type);
			_implementedTypes = implementedTypes;
			_constructor = constructor;
			_properties = properties;
			_methods = methods;
		}
		
		public function get implementedTypes():Vector.<Class>
		{
			return _implementedTypes;
		}
		
		public function get constructor():MethodMetadata
		{
			return _constructor;
		}
		
		public function get properties():Vector.<PropertyMetadata>
		{
			return _properties;
		}
		
		public function get methods():Vector.<MethodMetadata>
		{
			return _methods;
		}
		
		override public function toString():String
		{
			var s:String = annotations ? StringUtil.forEach(annotations, "\n") + "\n" : "";
			s += "class " + getQualifiedClassName(type) + (implementedTypes ? " implements " + StringUtil.forEach(implementedTypes, ", ") : "") + "\n";
			s += "{\n";
			s += constructor ? StringUtil.indent(constructor.toString()) + "\n\n" : "";
			s += methods ? StringUtil.indent(StringUtil.forEach(methods, "\n\n")) + "\n\n" : "";
			s += properties ? StringUtil.indent(StringUtil.forEach(properties, "\n\n")) + "\n" : "";
			s += "}";
				
			return s;
		}
	}
}