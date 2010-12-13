package ee.gunk.util
{
	public class StringUtil
	{
		/**
		 * Loops through the given vector and executes concatinates the elements with 
		 * the given separator.
		 */
		static public function forEach(vector:Object, separator:String = ""):String
		{
			var v:Vector.<Object> = Vector.<Object>(vector);
			var result:String = ""; 
			v.forEach(
				function(e:Object, ... rest):void
				{
					result += result.length ? separator : ""; 
					result += e.toString();	
				});
			return result;
		}
		
		/**
		 * Adds \t at the start of each line.
		 */
		static public function indent(str:String):String
		{
			return "\t" + str.replace(/\n/g, "\n\t");
		}
	}
}