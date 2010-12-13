package ee.gunk.provider
{
	import ee.gunk.IInjector;
	import ee.gunk.IKey;
	import ee.gunk.IKeyAwareProvider;
	import ee.gunk.IProvider;
	import ee.gunk.Key;
	import ee.gunk.annotation.IAnnotation;
	import ee.gunk.annotation.Type;
	import ee.gunk.util.IMap;
	import ee.gunk.util.ObjectMap;

	[Constructor("[Inject]")]
	/**
	 * The provider that is used to provide IProvider instances for 
	 * dependencies annotated with the [Type] annotation.
	 * 
	 * @see ee.gunk.annotation.Type
	 */
	public class DynamicProvider implements IKeyAwareProvider
	{
		private var _injector:IInjector;
		private var _providerCache:IMap;
		
		public function DynamicProvider(injector:IInjector)
		{
			_injector = injector;
			_providerCache = new ObjectMap();
		}

		/**
		 * Will throw an error of the given key does not meet the following conditions:
		 * <ul>
		 * 	<li>The type of the key has to be <code>IProvider</code></li>
		 * 	<li>The key should contain a <code>[Type("package.ClassName")]</code> annotation</li>
		 * </ul>
		 */
		public function getFor(key:IKey):Object
		{
			var fullHash:String = key.fullHash;
			var provider:IProvider;
			
			if (_providerCache.containsKey(fullHash))
			{
				provider = IProvider(_providerCache.get(fullHash));
			} else
			{
				if (key.type != IProvider)
				{
					throw new Error("Can only provide for keys with type IProvider, key: " + key);
				}
				
				//determine the actual type to provide
				var annotations:Vector.<IAnnotation> = key.annotations;
				var annotation:IAnnotation;
				
				var type:Class;
				var newAnnotations:Vector.<IAnnotation>;
				
				//look for the [Type] annotation and separate the rest for the new key
				for each (annotation in annotations)
				{
					if (annotation is Type)
					{
						type = Type(annotation).type;
					} else
					{
						if (!newAnnotations)
						{
							newAnnotations = new Vector.<IAnnotation>();
						}
						newAnnotations.push(annotation);
					}
				}
				
				if (!type)
				{
					throw new Error("The IProvider dependency is not annotated with a valid [Type(\"package.ClassName\")] annotation");
				}
				
				provider = _injector.getProviderFor(new Key(type, newAnnotations));
				
				_providerCache.put(fullHash, provider);
			}
			
			return provider;
		}

		/**
		 * This method is not implemented and will throw an error
		 */
		public function get():Object
		{
			throw new Error("This method is not implemented. The DynamicProvider can only provide for a key");
		}

	}
}