package ee.gunk.metadata
{
	import ee.gunk.util.DictionaryMap;
	import ee.gunk.util.IMap;
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	public class ClassMetadataUtils
	{
		static private var _annotationMetadataBuilder:IAnnotationMetadataBuilder = new AnnotationMetadataBuilder();
		
		static public function get annotationMetadataBuilder():IAnnotationMetadataBuilder
		{
			return _annotationMetadataBuilder;
		}
		
		static public function getConstructorArgumentCount(type:Class):uint
		{
			return _getCacheEntry(type).constructorArgumentCount;
		}
		
		static public function getConstructorArgumentCountFromDefinition(description:XML, type:Class):uint
		{
			return _getCacheEntryFromDefinition(description, type).constructorArgumentCount;
		}
		
		static public function getImplementedTypes(type:Class):Vector.<Class>
		{
			return _getCacheEntry(type).implementsTypes;
		}
		
		static public function getImplementedTypesFromDefinition(description:XML, type:Class):Vector.<Class>
		{
			return _getCacheEntryFromDefinition(description, type).implementsTypes;
		}
		
		static public function getAnnotationMetadata(type:Class):Vector.<AnnotationMetadata>
		{
			return _getCacheEntry(type).annotationMetadata;
		}
		
		static public function getAnnotationMetadataFromDefinition(description:XML, type:Class):Vector.<AnnotationMetadata>
		{
			return _getCacheEntryFromDefinition(description, type).annotationMetadata;
		}
		
		static private var _metadataCache:IMap = new DictionaryMap();
		
		static private function _getCacheEntry(type:Class):MetadataCacheEntry
		{
			return _getCacheEntryFromDefinition(describeType(type), type);
		}
		
		static private function _getCacheEntryFromDefinition(description:XML, type:Class):MetadataCacheEntry
		{
			if (_metadataCache.containsKey(type))
			{
				return MetadataCacheEntry(_metadataCache.get(type));
			} else
			{
				var metadataCacheEntry:MetadataCacheEntry = new MetadataCacheEntry();
				metadataCacheEntry.implementsTypes = _getImplementedTypesFromDefinition(description);
				metadataCacheEntry.constructorArgumentCount = _getConstructorArgumentCountFromDefinition(description);
				metadataCacheEntry.annotationMetadata = _getAnnotationMetadata(description);
				
				_metadataCache.put(type, metadataCacheEntry);
				
				return metadataCacheEntry;
			}
		}
		
		static private function _getImplementedTypesFromDefinition(description:XML):Vector.<Class>
		{
			var implementsTypes:Vector.<Class>;
			
			var implementsTypeList:XMLList = description.factory.implementsInterface;
			var implementType:XML;
			
			for each (implementType in implementsTypeList)
			{
				if (!implementsTypes)
				{
					implementsTypes = new Vector.<Class>();
				}
				
				implementsTypes.push(getDefinitionByName(implementType.@type));
			}
			
			return implementsTypes;
		}
		
		static private function _getConstructorArgumentCountFromDefinition(description:XML):uint
		{
			return description.factory.constructor.parameter.@type.length();
		}
		
		static private function _getAnnotationMetadata(description:XML):Vector.<AnnotationMetadata>
		{
			var annotationMetadata:Vector.<AnnotationMetadata>;
			var annotations:XMLList = description.factory.metadata.(@name != AnnotationNames.CONSTRUCTOR && @name != AnnotationNames.HELP && @name != AnnotationNames.CONSTRUCTOR_HELP);
			var annotation:XML;
			
			for each (annotation in annotations)
			{
				if (!annotationMetadata)
				{
					annotationMetadata = new Vector.<AnnotationMetadata>();
				}
				
				annotationMetadata.push(_annotationMetadataBuilder.build(annotation));
			}
			
			return annotationMetadata;
		}
	}
}
import ee.gunk.metadata.AnnotationMetadata;

class MetadataCacheEntry
{
	public var implementsTypes:Vector.<Class>;
	public var constructorArgumentCount:uint;
	public var annotationMetadata:Vector.<AnnotationMetadata>;
}