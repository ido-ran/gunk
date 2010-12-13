package ee.gunk.internals
{
	import ee.gunk.IInjector;
	import ee.gunk.IKey;
	import ee.gunk.IKeyAwareProvider;
	import ee.gunk.IProvider;
	import ee.gunk.util.ClassUtil;
	import ee.gunk.util.DictionaryMap;
	import ee.gunk.util.IMap;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @private
	 */
	internal final class DependencyInjector implements IDependencyInjector
	{
		private var _injector:IInjector;
		private var _dependencyFactory:IDependencyFactory;		
		
		private var _recursionDetection:IMap;
		
		public function DependencyInjector(injector:IInjector, dependencyFactory:IDependencyFactory)
		{
			_injector = injector;
			_dependencyFactory = dependencyFactory;
			
			_recursionDetection = new DictionaryMap();
		}
		
		private function _getValue(dependency:IKey):Object
		{
			var provider:IProvider = _injector.getProviderFor(dependency);
			var value:Object;
			
			if (provider is IKeyAwareProvider)
			{
				value = IKeyAwareProvider(provider).getFor(dependency);
			} else
			{
				value = provider.get();
			}
			
			return value;
		}
		
		public function createInstance(type:Class, context:ConstructionContext = null):Object
		{
			var hasContext:Boolean = context != null;
			var instance:Object = hasContext ? context.instance : null;
			
			if (!instance)
			{
				var classDependencies:ClassDependencies = _dependencyFactory.createClassDependencies(type);
	
				instance = _createInstance(type, classDependencies);
				
				if (hasContext)
				{
					context.instance = instance;
				}
				
				_injectDependencies(instance, classDependencies);
			}
			
			return instance;
		}
		
		private function _createInstance(type:Class, classDependencies:ClassDependencies):Object
		{
			var constructorDependencies:MethodDependencies = classDependencies ? classDependencies.constructorDependencies : null;
			
			if (constructorDependencies && constructorDependencies.argumentDependencies)
			{
				//we need to perform special instantiation
				var constructorArguments:Vector.<Object> = new Vector.<Object>();
				var dependencies:Vector.<IKey> = constructorDependencies.argumentDependencies;
				
				var i:uint;
				
				try
				{
					for (i = 0; i < dependencies.length; i++)
					{
						constructorArguments.push(_getValue(dependencies[i]));
					}
				} catch (e:ReferenceError)
				{
					throw new ReferenceError("Could not obtain value for constructor argument " + i + " of class '" + getQualifiedClassName(type) + "'.\n Original message: " + e.message);
				}
				
				return ClassUtil.createInstance(type, constructorArguments);
			} else
			{
				return new type();
			}
		}
		
		public function injectDependencies(instance:Object):void
		{
			_injectDependencies(instance, _dependencyFactory.createClassDependencies(instance));
		}
		
		private function _injectDependencies(instance:Object, classDependencies:ClassDependencies):void
		{
			//detect recursive injections
			var type:Class = ClassUtil.getClass(instance);
			if (_recursionDetection.containsKey(type))
			{
				throw new Error("Detected infinite recursion while injecting dependencies on type '" + type + "'. Please bind the types as singletons in order to prevent an infinit amount of instances");
			} else
			{
				_recursionDetection.put(type, null);
			}
			
			//property dependencies
			var propertyDependencies:Vector.<PropertyDependency> = classDependencies ? classDependencies.propertyDependencies : null;
			
			if (propertyDependencies)
			{
				var propertyDependency:PropertyDependency;
				try
				{
					for each (propertyDependency in propertyDependencies)
					{
						instance[propertyDependency.name] = _getValue(propertyDependency.dependency);
					}
				} catch (e:ReferenceError)
				{
					throw new ReferenceError("Could not obtain value for property '" + propertyDependency.name + "' of class '" + getQualifiedClassName(instance) + "'.\n Original message: " + e.message);
				}
			}
			
			//method dependencies
			var methodDependencies:Vector.<MethodDependencies> = classDependencies ? classDependencies.methodDependencies : null;
			
			if (methodDependencies)
			{
				var methodDependency:MethodDependencies;
				
				try
				{
					for each (methodDependency in methodDependencies)
					{
						callMethodWithDependencies(instance[methodDependency.name], methodDependency.argumentDependencies);
					}
				} catch (e:ReferenceError)
				{
					throw new ReferenceError("Could not obtain value for method '" + methodDependency.name + "' of class '" + getQualifiedClassName(instance) + "'.\n Original message: " + e.message);
				}
			}
			
			//construction complete, remove the type from recursion detection
			_recursionDetection.remove(type);
		}
		
		public function callMethodWithDependencies(method:Function, argumentDependencies:Vector.<IKey>):Object
		{
			var methodArguments:Array = [];
			var i:uint;
			
			try
			{
				for (i = 0; i < argumentDependencies.length; i++)
				{
					methodArguments.push(_getValue(argumentDependencies[i]));
				}
			} catch (e:ReferenceError)
			{
				throw new ReferenceError("Could not obtain value for argument " + i + ".\n Original message: " + e.message);
			}
			
			return method.apply(null, methodArguments);
		}
	}
}