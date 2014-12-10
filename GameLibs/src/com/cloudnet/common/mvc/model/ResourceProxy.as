package com.cloudnet.common.mvc.model
{
	import com.cloudnet.common.interfaces.IResourceHandle;
	import com.cloudnet.common.mvc.model.business.ResourceDelegate;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ResourceProxy extends Proxy implements IResourceHandle
	{
		public static const NAME:String = "ResourceProxy";
		private var _loaderDelegate:ResourceDelegate;
		
		public function ResourceProxy()
		{
			super(NAME);
			_loaderDelegate=new ResourceDelegate(this);
		}
		
		public function load(url:String, resourceName:String):void
		{
			_loaderDelegate.load(url, resourceName);
		}
		
		public function progressHandler(event:LoaderEvent):void
		{
			sendNotification(CommonNotification.RESOURCE_LOADER_PROGRESS,event.target.progress);
		}
		
		public function completeHandler(event:LoaderEvent):void
		{
			var loaderMax:LoaderMax = event.target as LoaderMax;
			//trace(loaderMax.name);
			
			this.data = loaderMax.getContent(_loaderDelegate.resourceName);
			
			sendNotification(CommonNotification.RESOURCE_LOADER_COMPLETE);
		}
		
		public function errorHandler(event:LoaderEvent):void
		{
			sendNotification(CommonNotification.RESOURCE_LOADER_ERROR,event.text);
		}
		
		public function get resourceData():XML
		{
			return XML(this.data).copy();
		}
	}
}