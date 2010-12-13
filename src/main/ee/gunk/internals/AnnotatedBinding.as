package ee.gunk.internals
{
	import ee.gunk.IBinding;
	import ee.gunk.IProvider;
	import ee.gunk.Key;
	import ee.gunk.annotation.IAnnotation;
	
	/**
	 * @private
	 */
	internal final class AnnotatedBinding extends AbstractBinding
	{
		private var _annotations:Vector.<IAnnotation>;
		
		public function AnnotatedBinding(_dependencyInjector:IDependencyInjector, base:IBinding, annotations:Vector.<IAnnotation>)
		{
			_annotations = annotations;
			
			var type:Class = base.key.type;
			
			super(new ClassProvider(_dependencyInjector, type), new Key(type, annotations));
		}
		
		public function get annotations():Vector.<IAnnotation>
		{
			return _annotations;
		}
	}
}