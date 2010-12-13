package ee.gunk.util
{
	import flash.utils.getQualifiedClassName;

	public function assertAbstract(instance:Object, type:Class):void
	{
		var className:String = getQualifiedClassName(type);
		if (getQualifiedClassName(instance) == className)
		{
			throw new Error("Can not instantiate " + className + " it's an abstract class. Extend it before instantiating");
		}
	}
}