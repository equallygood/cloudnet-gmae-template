package com.cloudnet.common.mvc.model.business
{
	import com.cloudnet.common.interfaces.IResourceHandle;
	import com.greensock.loading.*;

	public class ResourceDelegate
	{
		private var _proxy:IResourceHandle;
		
		private var _resourceName:String;
		
		public function get resourceName():String
		{
			return _resourceName;
		}
		
		public function ResourceDelegate(proxy:IResourceHandle)
		{
			LoaderMax.activate([ImageLoader, SWFLoader, DataLoader, MP3Loader]);
			_proxy=proxy;
		}
		
		public function load(url:String, resourceName:String):void
		{
			_resourceName = resourceName;
			
			var time:Number=new Date().time;
			var timeStamp:String="?time="+time;
			url+=timeStamp;
			
			var loader:XMLLoader = new XMLLoader(url, {name:resourceName});
			loader.load();
			
			var queue:LoaderMax = new LoaderMax({name:"ResourceQueue", onProgress:_proxy.progressHandler, onComplete:_proxy.completeHandler, onError:_proxy.errorHandler});
			
			queue.append( loader );
			
			queue.load();
		}
	}
}