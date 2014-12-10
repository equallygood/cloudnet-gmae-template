package com.cloudnet.common.mvc.model
{
	import com.cloudnet.common.interfaces.IDataHandle;
	import com.cloudnet.common.mvc.model.business.DataLoaderDelegate;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class JSONLoaderProxy extends Proxy implements IDataHandle
	{
		private var _dataLoader:DataLoaderDelegate
		private var _jsonData:Object;
		
		public function JSONLoaderProxy(proxyName:String)
		{
			super(proxyName);
			
			_dataLoader=new DataLoaderDelegate(this);
		}
		
		public function load(request:URLRequest, data:URLVariables=null, method:String = URLRequestMethod.POST):void
		{
			_dataLoader.load(request, data, method);
		}
		
		public function progressHandler(event:ProgressEvent):void
		{
			//trace(event.target.progress);
		}
		
		public function completeHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			
			_jsonData = JSON.parse(loader.data);
			
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			
			trace("JSONLoaderProxy",_jsonData.string);
		}
		
		public function errorHandler(event:IOErrorEvent):void
		{
			trace(event.text);
		}
	}
}