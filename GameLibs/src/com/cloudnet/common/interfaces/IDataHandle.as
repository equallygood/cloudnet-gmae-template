package com.cloudnet.common.interfaces
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	public interface IDataHandle
	{
		function progressHandler(e:ProgressEvent):void;
		function completeHandler(e:Event):void;
		function errorHandler(e:IOErrorEvent):void
	}
}