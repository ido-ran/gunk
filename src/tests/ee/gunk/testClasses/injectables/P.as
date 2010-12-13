package ee.gunk.testClasses.injectables
{
	import ee.gunk.IProvider;
	import ee.gunk.testClasses.interfaces.I1;
	import ee.gunk.testClasses.interfaces.I2;
	import ee.gunk.testClasses.types.TestType1;
	import ee.gunk.testClasses.types.TestType2;
	import ee.gunk.testClasses.types.TestType3;

	public class P
	{
		[Inject]
		public var property1:TestType1;
		
		[Inject]
		[Custom]
		public var property2:TestType2; 
		
		[Inject]
		[Named("property")]
		public var property3:TestType1; 
		
		[Inject]
		[Type("ee.gunk.testClasses.types.TestType1")]
		public var property4:IProvider;
		
		[Inject]
		public var property5:I1;
		
		[Inject]
		public var property6:I2;
		
		[Inject]
		public var property7:TestType3;
		
		[Custom]
		public var property8:TestType1;
	}
}