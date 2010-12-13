package ee.gunk.metadata
{
	import flash.utils.getDefinitionByName;

	/**
	 * @private
	 */
	internal final class PropertyMetadataBuilder
	{
		private var _annotationMetdataBuilder:IAnnotationMetadataBuilder;
		private var _onlyAnnotated:Boolean;
		
		public function PropertyMetadataBuilder(annotationMetdataBuilder:IAnnotationMetadataBuilder)
		{
			_annotationMetdataBuilder = annotationMetdataBuilder;
		}
		
		public function build(definition:XML):Vector.<PropertyMetadata>
		{
			var properties:XMLList = definition.factory.children().
				(
					//only variables or accessors that can be written to
					(
						name() == "variable" || 
						(
							name() == "accessor" && 
							(@access == "writeonly" || @access == "readwrite")
						)
					) &&
					hasOwnProperty("metadata") && 
					metadata.length() != metadata.(@name == AnnotationNames.HELP).length() &&
					(
						!hasOwnProperty("@declaredBy") ||
						(
							@declaredBy.indexOf("flash.") < 0 &&
							@declaredBy.indexOf("mx.") < 0 &&
							@declaredBy.indexOf("spark.") < 0
						)
					)
				);
			
			var property:XML;
			
			var propertyMetadata:Vector.<PropertyMetadata>;
			
			for each (property in properties)
			{
				if (!propertyMetadata)
				{
					propertyMetadata = new Vector.<PropertyMetadata>();
				}
				
				propertyMetadata.push(_createPropertyMetadata(property));
			}
			
			return propertyMetadata;
		}
		
		public function _createPropertyMetadata(definition:XML):PropertyMetadata
		{
			var type:Class = Class(getDefinitionByName(definition.@type));
			var name:String = definition.@name;
			
			var annotationMetadata:Vector.<AnnotationMetadata>;
			
			var metadataList:XMLList = definition.metadata.(@name != AnnotationNames.HELP);
			var metadata:XML;
			
			for each (metadata in metadataList)
			{
				if (!annotationMetadata)
				{
					annotationMetadata = new Vector.<AnnotationMetadata>();
				}
				
				annotationMetadata.push(_annotationMetdataBuilder.build(metadata));
			}
			
			return new PropertyMetadata(annotationMetadata, type, name); 
			
		}
	}
}