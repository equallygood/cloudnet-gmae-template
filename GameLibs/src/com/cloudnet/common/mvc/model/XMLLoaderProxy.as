package com.cloudnet.common.mvc.model
{
	import com.cloudnet.common.interfaces.IDataHandle;
	import com.cloudnet.common.interfaces.IResourceHandle;
	import com.cloudnet.common.mvc.model.business.DataLoaderDelegate;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class XMLLoaderProxy extends Proxy implements IDataHandle
	{
		private var _dataLoader:DataLoaderDelegate;
		private var _xmlData:XML;
		
		public function get xmlData():XML
		{
			return _xmlData;
		}
		
		public function XMLLoaderProxy(proxyName:String=null)
		{
			super(proxyName);
			
			_dataLoader=new DataLoaderDelegate(this);
		}
		
		public function load(request:URLRequest, data:URLVariables=null, method:String = URLRequestMethod.POST):void
		{
			_dataLoader.load(request, data, method);
		}
		
		public function progressHandler(e:ProgressEvent):void
		{
			//trace(event.target.progress);
		}
		
		public function completeHandler(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			
			_xmlData = XML(loader.data).copy();
			
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			
			//trace("XMLLoaderProxy",_xmlData);
		}
		
		public function errorHandler(e:IOErrorEvent):void
		{
			trace(e.text);
		}
	}
}