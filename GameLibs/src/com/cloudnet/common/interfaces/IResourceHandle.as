package com.cloudnet.common.interfaces
{
	import com.greensock.events.LoaderEvent;
	
	public interface IResourceHandle
	{	
		function progressHandler(e:LoaderEvent):void;
		function completeHandler(e:LoaderEvent):void;
		function errorHandler(e:LoaderEvent):void
	}
}