package ee.gunk.metadata
{
	import ee.gunk.util.IMap;
	import ee.gunk.util.ObjectMap;
	
	/**
	 * @private
	 */
	internal final class AnnotationMetadataBuilder implements IAnnotationMetadataBuilder
	{
		static private const _annotation:RegExp = /\s*\[\s*(?P<name>.*?)\s*(\(\s*(?P<content>.*?)\s*\)\s*)?]/g;
		static private const _annotationArgument:RegExp = /\s*,?\s*(?:(?P<key>[^']*?)\s*=\s*)?'(?P<values>.*?)'/g;
		
		public function AnnotationMetadataBuilder()
		{
		}
		
		public function build(definition:XML, allowArgumentAnnotations:Boolean = false):AnnotationMetadata
		{
			var name:String = definition.@name;
			var lookForArgumentAnnotations:Boolean = allowArgumentAnnotations || name == AnnotationNames.ARGUMENTS;
			
			var argumentAnnotations:Vector.<Vector.<AnnotationMetadata>> = null;
			
			var keyCount:uint = definition.arg.length();
			var values:IMap;
			var defaultValue:String;
			
			if (keyCount)
			{
				var args:XMLList = definition.arg;
				var arg:XML;
				var key:String;
				var value:String;
				var index:Number;
				
				for each (arg in args)
				{
					key = arg.@key;
					value = arg.@value;
					
					if (key.length)
					{
						//check if we are dealing with an index
						if (!lookForArgumentAnnotations || isNaN(index = parseInt(key)))
						{
							if (!values)
							{
								values = new ObjectMap();
							}
							
							values.put(key, value);
						} else
						{
							//we are dealing with argument annotations
							if (!argumentAnnotations)
							{
								argumentAnnotations = new Vector.<Vector.<AnnotationMetadata>>();
							}
							
							argumentAnnotations.length = index + 1;
							
							argumentAnnotations[index] = buildFromString(value);
						}
					} else
					{
						//we found a default value
						defaultValue = value;
					}
				}
			}
			
			if (argumentAnnotations)
			{
				return new MethodAnnotationMetadata(name, defaultValue, values, argumentAnnotations);
			} else
			{
				return new AnnotationMetadata(name, defaultValue, values);
			}
		}
		
		public function buildFromString(definition:String):Vector.<AnnotationMetadata>
		{
			var annotationsMetadata:Vector.<AnnotationMetadata> = new Vector.<AnnotationMetadata>();
			
			var annotation:Array;
			var annotationArgument:Array;
			var name:String;
			var key:String;
			var value:String;
			var content:String;
			
			var values:IMap = null;
			var defaultValue:String = null;
			
			_annotation.lastIndex = 0;
			
			while (annotation = _annotation.exec(definition))
			{
				values = null;
				defaultValue = null;
				
				name = annotation.name;
				content = annotation.content;
				
				_annotationArgument.lastIndex = 0;
				
				while (content && (annotationArgument = _annotationArgument.exec(content)))
				{
					key = null;
					
					if (annotationArgument.hasOwnProperty("key"))
					{
						key = annotationArgument.key;
					}
					
					value = annotationArgument.values;

					if (key && key.length)
					{
						if (!values)
						{
							values = new ObjectMap();
						}
						
						values.put(key, value);
					} else
					{
						defaultValue = value;
					}
				}
				
				annotationsMetadata.push(new AnnotationMetadata(name, defaultValue, values));
			}
			
			return annotationsMetadata;
		}
	}
}