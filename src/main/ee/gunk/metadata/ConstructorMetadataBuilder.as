package ee.gunk.metadata
{
	import ee.gunk.util.ClassUtil;
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * @private
	 */
	internal final class ConstructorMetadataBuilder
	{
		private var _annotationMetdataBuilder:IAnnotationMetadataBuilder;
		
		public function ConstructorMetadataBuilder(annotationMetdataBuilder:IAnnotationMetadataBuilder)
		{
			_annotationMetdataBuilder = annotationMetdataBuilder;
		}
		
		public function build(definition:XML, type:Class):MethodMetadata
		{
			var factory:XMLList = definition.factory;
			var constructor:XMLList = factory.constructor;
			var parameterCount:uint = ClassMetadataUtils.getConstructorArgumentCountFromDefinition(definition, type);
			
			//we need to check if the types are available
			if (parameterCount && parameterCount == constructor.parameter.(@type == "*").length())
			{
				//types are not available, create a dummy instance (forces the types to become available)
				try
				{
					ClassUtil.createInstance(type, new Vector.<Object>(parameterCount, true));
				} catch (e:Error)
				{
					//ignore errors
				}
				
				//reset the references
				definition = describeType(type);
				factory = definition.factory;
				constructor = factory.constructor;
			}
			
			//since constructors can not have metadata we have to get it from the class
			var constructorMetadata:XMLList = factory.metadata.(@name == AnnotationNames.CONSTRUCTOR);
			var annotationMetadata:AnnotationMetadata;
			var defaultValue:String;
			
			if (constructorMetadata.length())
			{
				annotationMetadata = _annotationMetdataBuilder.build(constructorMetadata[0], true);
				defaultValue = annotationMetadata.defaultValue;
			} else
			{
				return null;
			}
			
			var constructorAnnotations:Vector.<AnnotationMetadata>;
			
			if (defaultValue)
			{
				//check if this contains any metadata
				constructorAnnotations = _annotationMetdataBuilder.buildFromString(defaultValue);
			}
				
			var argumentAnnotations:Vector.<Vector.<AnnotationMetadata>>;
			
			if (annotationMetadata is MethodAnnotationMetadata)
			{
				//we have argument annotations
				var methodAnnotationMetadata:MethodAnnotationMetadata = MethodAnnotationMetadata(annotationMetadata);
				argumentAnnotations = methodAnnotationMetadata.argumentAnnotations;
			}
			
			//process the arguments
			var parameters:XMLList = constructor.parameter;
			var argumentMetadata:Vector.<TypeMetadata>;
			var argument:XML;
			var annotations:Vector.<AnnotationMetadata>;
			var index:Number;
			
			for each (argument in parameters)
			{
				index = parseInt(argument.@index);
				
				//index starts at one for parameters
				if (!isNaN(index) && argumentAnnotations && index - 1 < argumentAnnotations.length)
				{
					annotations = argumentAnnotations[index - 1];
				} else
				{
					annotations = null;
				}
				
				if (!argumentMetadata)
				{
					argumentMetadata = new Vector.<TypeMetadata>();
				}

				argumentMetadata.push(new TypeMetadata(annotations, Class(getDefinitionByName(argument.@type)))); 
			}
			
			//return the method metadata
			return new MethodMetadata(constructorAnnotations, null, null, argumentMetadata);
		}
	}
}