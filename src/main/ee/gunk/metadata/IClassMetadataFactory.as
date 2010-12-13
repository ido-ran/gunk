package ee.gunk.metadata
{
	[ImplementedBy("ee.di.metadata.ClassMetadataFactory")]
	public interface IClassMetadataFactory
	{
		function getClassMetadata(object:Object):ClassMetadata;
	}
}