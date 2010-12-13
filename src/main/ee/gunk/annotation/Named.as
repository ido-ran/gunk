package ee.gunk.annotation
{
	/**
	 * Named annotation: <code>[Named("name")]</code>
	 * 
	 * @see Names
	 */
	public class Named extends AbstractAnnotation
	{
		public function Named(defaultValue:String)
		{
			super(defaultValue, null);
		}
		
		/**
		 * Returns the default value
		 */
		public function get name():String
		{
			return defaultValue;
		}
	}
}