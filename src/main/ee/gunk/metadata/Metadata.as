package ee.gunk.metadata
{

	public class Metadata
	{
		private var _annotations:Vector.<AnnotationMetadata>;
		
		public function Metadata(annotations:Vector.<AnnotationMetadata>)
		{
			_annotations = annotations;
		}
		
		public function get annotations():Vector.<AnnotationMetadata>
		{
			return _annotations;
		}		
	}
}