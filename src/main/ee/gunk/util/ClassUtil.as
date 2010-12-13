package ee.gunk.util
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ClassUtil
	{
		/**
		 * Constructs an instance of the given type with up to 9 constructor arguments
		 */
		static public function createInstance(type:Class, constructorArguments:Vector.<Object>):Object
		{
			var a:Vector.<Object> = constructorArguments;
			
			switch (a.length)
			{
				case 0:
					return new type();				
				case 1:
					return new type(a[0]); 
				case 2:
					return new type(a[0], a[1]); 
				case 3:
					return new type(a[0], a[1], a[2]); 
				case 4:
					return new type(a[0], a[1], a[2], a[3]); 
				case 5:
					return new type(a[0], a[1], a[2], a[3], a[4]); 
				case 6:
					return new type(a[0], a[1], a[2], a[3], a[4], a[5]); 
				case 7:
					return new type(a[0], a[1], a[2], a[3], a[4], a[5], a[6]); 
				case 8:
					return new type(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]); 
				case 9:
					return new type(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8]);
				default:
					throw new Error("Could not create instance, too many constructor arguments. Refactor the class so it has 9 or less constructor arguments"); 
			}
		}
		
		/**
		 * Retrieves the class of a given instance, ignoring reference errors.
		 */
		static public function getClass(instance:Object):Class
		{
			try
			{
				return Class(getDefinitionByName(getQualifiedClassName(instance)));
			} catch (e:ReferenceError)
			{
				//the class definition is not reachable, it might be an inner class or a class marked with internal
			}
			
			return null;
		}
	}
}