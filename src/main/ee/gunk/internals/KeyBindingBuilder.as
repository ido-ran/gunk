package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IKey;
	import ee.gunk.annotation.IAnnotation;
	
	/**
	 * @private
	 */
	internal class KeyBindingBuilder extends BindingBuilder
	{
		public function KeyBindingBuilder(bindings:Vector.<IBinding>, dependencyInjector:IDependencyInjector, annotationRegistry:IAnnotationRegistry, key:IKey)
		{
			super(bindings, dependencyInjector, annotationRegistry, key.type);
			
			var annotations:Vector.<IAnnotation> = key.annotations;
			if (annotations)
			{
				annotatedWith(annotations);
			}
		}
	}
}