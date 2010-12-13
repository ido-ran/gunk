package ee.gunk.annotation
{
	import flash.utils.getDefinitionByName;
	
	/**
	 * Annotation that can be used to specify a type.
	 * 
	 * @see ee.di.providers.DynamicProvider
	 */
	public class Type extends AbstractAnnotation
	{
		private var _type:Class;
		
		public function Type(defaultValue:String)
		{
			super(defaultValue, null);
		}
		
		/**
		 * Returns the Class for the type specified as default value. Will throw an error 
		 * if the type could not be found.
		 */
		public function get type():Class
		{
			if (!_type)
			{
				try
				{
					_type = Class(getDefinitionByName(defaultValue));
				} catch (e:ReferenceError)
				{
					throw new ReferenceError("Could not obtain class '" + defaultValue + "' from annotation [Type]");
				}
			}
			
			return _type;
		}
	}
}