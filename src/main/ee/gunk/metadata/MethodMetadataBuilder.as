package ee.gunk.metadata
{
	import flash.utils.getDefinitionByName;

	/**
	 * @private
	 */
	internal final class MethodMetadataBuilder
	{
		private var _annotationMetdataBuilder:IAnnotationMetadataBuilder;
		private var _onlyAnnotated:Boolean;
		
		public function MethodMetadataBuilder(annotationMetdataBuilder:IAnnotationMetadataBuilder)
		{
			_annotationMetdataBuilder = annotationMetdataBuilder;
		}
		
		public function build(definition:XML):Vector.<MethodMetadata>
		{
			var methods:XMLList = definition.factory.method.
				(
					hasOwnProperty("metadata") && 
					metadata.length() != metadata.(@name == AnnotationNames.HELP).length() &&
					@declaredBy.indexOf("flash.") < 0 &&
					@declaredBy.indexOf("mx.") < 0 &&
					@declaredBy.indexOf("spark.") < 0
				);
			
			var methodMetadata:Vector.<MethodMetadata>;
			
			var method:XML;
			
			for each (method in methods)
			{
				if (!methodMetadata)
				{
					methodMetadata = new Vector.<MethodMetadata>();
				}
				
				methodMetadata.push(_createMethodMetadata(method));
			}
			
			return methodMetadata;
		}
		
		private function _createMethodMetadata(definition:XML):MethodMetadata
		{
			var name:String = definition.@name;
			var returnTypeName:String = definition.@returnType;
			var returnType:Class = returnTypeName == "void" ? null : Class(getDefinitionByName(returnTypeName));
			
			var methodAnnotationsMetadata:Vector.<AnnotationMetadata>;
			var metadataList:XMLList = definition.metadata.(@name != AnnotationNames.HELP);
			var metadata:XML;
			var methodAnnotationMetadata:AnnotationMetadata;
			var argumentAnnotations:Vector.<Vector.<AnnotationMetadata>>;
			
			for each (metadata in metadataList)
			{
				methodAnnotationMetadata = _annotationMetdataBuilder.build(metadata);
				
				if (methodAnnotationMetadata is MethodAnnotationMetadata)
				{
					argumentAnnotations = MethodAnnotationMetadata(methodAnnotationMetadata).argumentAnnotations;
				} else
				{
					if (!methodAnnotationsMetadata)
					{
						methodAnnotationsMetadata = new Vector.<AnnotationMetadata>();
					}
					
					methodAnnotationsMetadata.push(methodAnnotationMetadata);
				}
			}
			
			//process the arguments
			var parameters:XMLList = definition.parameter;
			var argumentMetadata:Vector.<TypeMetadata>;
			var argument:XML;
			var annotations:Vector.<AnnotationMetadata>;
			var index:Number;
			
			for each (argument in parameters)
			{
				index = parseInt(argument.@index) - 1;
				
				if (argumentAnnotations && index < argumentAnnotations.length)
				{
					annotations = argumentAnnotations[index];
				} else
				{
					annotations = null;
				}
				
				if (!argumentMetadata)
				{
					argumentMetadata = new Vector.<TypeMetadata>(parameters.length())
				}
				
				argumentMetadata[index] = new TypeMetadata(annotations, Class(getDefinitionByName(argument.@type))); 
			}
			
			return new MethodMetadata(methodAnnotationsMetadata, returnType, name, argumentMetadata);
		}
	}
}