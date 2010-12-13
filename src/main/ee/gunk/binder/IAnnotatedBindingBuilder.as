package ee.gunk.binder
{
	/**
	 * The binding builder to created annotated bindings
	 */
	public interface IAnnotatedBindingBuilder extends ILinkedBindingBuilder
	{
		/**
		 * Builds a binding that has one or more annotations.
		 * 
		 * @param annotation	Can be an annotation instance implementing IAnnotation, an array 
		 * 						of instances implementing IAnnotation, a class implementing 
		 * 						IAnnotation or an array of classes implementing IAnnotation
		 */ 
		function annotatedWith(annotation:Object):ILinkedBindingBuilder;
	}
}