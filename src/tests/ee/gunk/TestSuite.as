package ee.gunk
{
	import ee.gunk.features.CircularDependencyTest;
	import ee.gunk.features.CompositionInjectionTest;
	import ee.gunk.features.ConstructorInjectionTest;
	import ee.gunk.features.MethodInjectionTest;
	import ee.gunk.features.ModuleProvidesTest;
	import ee.gunk.features.PropertyInjectionTest;
	import ee.gunk.internals.AnnotationRegistryTest;
	import ee.gunk.internals.BinderTest;
	import ee.gunk.internals.BindingBuilderTest;
	import ee.gunk.internals.BindingRegistryTest;
	import ee.gunk.internals.DependencyFactoryTest;
	import ee.gunk.internals.DependencyInjectorTest;
	import ee.gunk.internals.InjectorTest;
	import ee.gunk.metadata.AnnotationMetadataBuilderTest;
	import ee.gunk.metadata.ClassMetadataFactoryTest;
	import ee.gunk.metadata.ConstructorMetadataBuilderTest;
	import ee.gunk.metadata.MethodMetadataBuilderTest;
	import ee.gunk.metadata.PropertyMetadataBuilderTest;
	import by.blooddy.crypto.MD5Test;
	import ee.gunk.util.assertAbstractTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite
	{
		//di.metadata
		public var t01:AnnotationMetadataBuilderTest;
		public var t02:ClassMetadataFactoryTest;		
		public var t03:ConstructorMetadataBuilderTest;
		public var t04:MethodMetadataBuilderTest;
		public var t05:PropertyMetadataBuilderTest;
		
		//di.internals
		public var t06:AnnotationRegistryTest;		
		public var t07:BinderTest;		
		public var t08:BindingBuilderTest;		
		public var t09:BindingRegistryTest;		
		public var t10:DependencyFactoryTest;		
		public var t11:DependencyInjectorTest;		
		public var t12:InjectorTest;		
		
		//di
		public var t14:SignatureTest;
		
		//features
		public var t15:ConstructorInjectionTest;
		public var t16:PropertyInjectionTest;
		public var t17:MethodInjectionTest;
		public var t18:ModuleProvidesTest;
		public var t19:CompositionInjectionTest;
		public var t20:CircularDependencyTest;
		
		//util
		public var t21:assertAbstractTest;
		public var t22:MD5Test;
	}
}