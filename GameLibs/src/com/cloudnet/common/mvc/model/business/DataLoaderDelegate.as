package com.cloudnet.common.mvc.model.business
{
	import com.cloudnet.common.interfaces.IDataHandle;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class DataLoaderDelegate
	{
		private var _proxy:IDataHandle;
		
		public function DataLoaderDelegate(proxy:IDataHandle)
		{
			_proxy = proxy;
			
		}
		
		public function load(request:URLRequest, data:URLVariables=null, method:String = URLRequestMethod.POST):void
		{
			if(data)
			{
				request.data = data;
			}
			request.method = method;
			
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, _proxy.completeHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, _proxy.progressHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _proxy.errorHandler);
			
			loader.load(request);
		}
	}
}