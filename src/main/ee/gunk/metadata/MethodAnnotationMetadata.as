package ee.gunk.metadata
{
	import ee.gunk.util.IMap;

	public class MethodAnnotationMetadata extends AnnotationMetadata
	{
		private var _argumentAnnotations:Vector.<Vector.<AnnotationMetadata>>;
		
		public function MethodAnnotationMetadata(name:String, defaultValue:String, values:IMap, argumentAnnotations:Vector.<Vector.<AnnotationMetadata>>)
		{
			super(name, defaultValue, values);
			
			_argumentAnnotations = argumentAnnotations;
		}
		
		public function get argumentAnnotations():Vector.<Vector.<AnnotationMetadata>>
		{
			return _argumentAnnotations;
		}
	}
}