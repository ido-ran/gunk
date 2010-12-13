package ee.gunk.metadata
{
	
	public class AnnotationMetadataBuilderStub implements IAnnotationMetadataBuilder
	{
		private var _annotationMetdata:AnnotationMetadata;
		
		public function AnnotationMetadataBuilderStub()
		{
			_annotationMetdata = new AnnotationMetadata(null, null, null);
		}
		
		public function set methodAnnotation(value:uint):void
		{
			if (value)
			{
				var em:Vector.<Vector.<AnnotationMetadata>> = new Vector.<Vector.<AnnotationMetadata>>();
				while (value--)
				{
					em.push(new Vector.<AnnotationMetadata>());
				}
				
				_annotationMetdata = new MethodAnnotationMetadata(null, null, null, em);
			}
		}
		
		public function set defaultValue(value:Boolean):void
		{
			if (value)
			{
				_annotationMetdata = new AnnotationMetadata(null, "defaultValue", null);
			}
		}
		
		public function build(definition:XML, allowArgumentAnnotations:Boolean=false):AnnotationMetadata
		{
			return _annotationMetdata;
		}

		public function buildFromString(definition:String):Vector.<AnnotationMetadata>
		{
			return new Vector.<AnnotationMetadata>(1);
		}
	}
}