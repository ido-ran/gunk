package ee.gunk.testClasses.injectables
{

	public class Composition
	{
		[Inject]
		public var constructorInjection:C1;
		[Inject]
		public var methodInjection:M;
		[Inject]
		public var propertyInjection:P;
		[Inject]
		public var accessorInjection:A;
	}
}