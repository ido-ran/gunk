package ee.gunk.metadata
{

	public interface IAnnotationMetadataBuilder
	{
		function build(definition:XML, allowArgumentAnnotations:Boolean = false):AnnotationMetadata
		function buildFromString(definition:String):Vector.<AnnotationMetadata>;
	}
}