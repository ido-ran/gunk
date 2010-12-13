package ee.gunk.testClasses.invisible
{
	public class InvisibleClassFactory
	{
		static public function getInvisibleClassInstance():InvisibleClass
		{
			return new InvisibleClass();
		}
	}
}

class InvisibleClass
{
}