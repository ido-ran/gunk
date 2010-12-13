package ee.gunk.internals
{
	import ee.gunk.IBinder;
	import ee.gunk.IBinding;
	import ee.gunk.IKey;

	/**
	 * @private
	 */
	internal interface IInternalBinder extends IBinder
	{
		function getBinding(key:IKey):IBinding;
	}
}