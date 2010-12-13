package ee.gunk.metadata
{
	import ee.gunk.util.ClassUtil;
	
	import flash.utils.describeType;

	/**
	 * Only constructs metadata for types that have annotations. If a member of the class 
	 * has no annotations no metadata will be generated
	 */
	public class ClassMetadataFactory implements IClassMetadataFactory
	{
		private var _constructorMetadataBuilder:ConstructorMetadataBuilder;
		private var _propertyMetadataBuilder:PropertyMetadataBuilder;
		private var _methodMetadataBuilder:MethodMetadataBuilder;
		private var _annotationMetadataBuilder:IAnnotationMetadataBuilder;
		
		public function ClassMetadataFactory()
		{
			_annotationMetadataBuilder = ClassMetadataUtils.annotationMetadataBuilder;
			_constructorMetadataBuilder = new ConstructorMetadataBuilder(_annotationMetadataBuilder);
			_methodMetadataBuilder = new MethodMetadataBuilder(_annotationMetadataBuilder);
			_propertyMetadataBuilder = new PropertyMetadataBuilder(_annotationMetadataBuilder);
		}
		
		public function getClassMetadata(object:Object):ClassMetadata
		{
			var type:Class;
			
			if (object is Class)
			{
				type = Class(object);
			} else
			{
				type = ClassUtil.getClass(object);
			}
			
			if (type)
			{
				return _buildClassMetadata(type);
			} else
			{
				return null;
			}
		}
		
		private function _buildClassMetadata(type:Class):ClassMetadata
		{
			/*
				Although calling describeType is expensive, the result is not cached as 
				this would result in excessive memory consumption. Improved performance 
				through caching should be done outside of this class.
			*/
			var description:XML = describeType(type);
			var implementsTypes:Vector.<Class> = ClassMetadataUtils.getImplementedTypesFromDefinition(description, type);
			var constructorMetadata:MethodMetadata = _constructorMetadataBuilder.build(description, type);
			var propertyMetadata:Vector.<PropertyMetadata> = _propertyMetadataBuilder.build(description);
			var methodMetadata:Vector.<MethodMetadata> = _methodMetadataBuilder.build(description);
			
			var annotationMetadata:Vector.<AnnotationMetadata> = ClassMetadataUtils.getAnnotationMetadataFromDefinition(description, type);
			
			if (annotationMetadata || constructorMetadata || propertyMetadata || methodMetadata)
			{
				return new ClassMetadata(annotationMetadata, type, implementsTypes, constructorMetadata, propertyMetadata, methodMetadata);
			} else
			{
				return null;
			}
		}
	}
}