package ee.gunk
{
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.util.IHashObject;

	/**
	 * A key is used in two places:
	 * <ol>
	 * 	<li>To uniquely identify a binding</li>
	 * 	<li>To uniquely identify a dependency</li>
	 * </ol>
	 * <p/>
	 * The hash of a key represents the type and the names of the 
	 * annotations. The full hash also takes the default value and 
	 * values of the annotation into account. 
	 */
	public interface IKey extends IHashObject
	{
		/**
		 * The type associated with the key
		 */
		function get type():Class;
		
		/**
		 * The annotations of this key
		 */
		function get annotations():Vector.<IAnnotation>;
		
		/**
		 * A hash representing the information in this object
		 */
		function get fullHash():String;
	}
}