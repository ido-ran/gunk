package ee.gunk.annotation
{
	import ee.gunk.util.IHashObject;
	import ee.gunk.util.IMap;

	/**
	 * Defines an annotation as used by DI
	 */
	public interface IAnnotation extends IHashObject
	{
		/**
		 * Default value of the annotation: [AnnotationName("defaultValue")]
		 */
		function get defaultValue():String;
		
		/**
		 * Map containing key-value pairs of the annotation: [AnnotationName(key1="value1")]
		 */
		function get values():IMap;
		
		/**
		 * The name of the annotation: [AnnotationName]
		 */
		function get annotationName():String;
	}
}