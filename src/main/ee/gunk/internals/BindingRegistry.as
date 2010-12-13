package ee.gunk.internals
{
	import ee.gunk.IKey;
	import ee.gunk.IBinding;
	import ee.gunk.util.IMap;
	import ee.gunk.util.ObjectMap;

	/**
	 * @private
	 */
	internal final class BindingRegistry implements IBindingRegistry
	{
		private var _bindingsByHash:IMap;
		private var _bindingsByFullHash:IMap;
		
		public function BindingRegistry()
		{
			_bindingsByHash = new ObjectMap();
			_bindingsByFullHash = new ObjectMap();
		}
		
		public function addBinding(binding:IBinding):void
		{
			var key:IKey = binding.key;
			var hash:String = key.hash;
			var fullHash:String = key.fullHash;
			
			if (_bindingsByFullHash.containsKey(fullHash))
			{
				throw new Error("Binding already exists: " + binding);
			}
			_bindingsByFullHash.put(fullHash, binding);
			
			var addToBindingsByHash:Boolean = true;
			
			if (_bindingsByHash.containsKey(hash))
			{
				var existingBinding:IBinding = IBinding(_bindingsByHash.get(hash));
				/*
					Simple bindings have preference over complex bindings.
					If the fullHash is equal to the hash, it's a simple binding 
					and might be intended to be a catch all binding.
				*/
				addToBindingsByHash = existingBinding.key.fullHash != hash;
			}
			
			if (addToBindingsByHash)
			{
				_bindingsByHash.put(hash, binding);
			}
		}
		
		public function hasBinding(key:IKey):Boolean
		{
			return _bindingsByFullHash.containsKey(key.fullHash) || _bindingsByHash.containsKey(key.hash);
		}
		
		public function getBinding(key:IKey):IBinding
		{
			return IBinding(_bindingsByFullHash.get(key.fullHash) || _bindingsByHash.get(key.hash));
		}
	}
}