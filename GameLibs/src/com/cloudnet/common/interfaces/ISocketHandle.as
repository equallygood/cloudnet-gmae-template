package com.cloudnet.common.interfaces
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;

	public interface ISocketHandle
	{
		function connectionHandler( e:Event ):void;
		function socketDataHandler(e:ProgressEvent):void;
		function closedHandler( e:Event ):void;
		function socketFailureHandler( e:IOErrorEvent ):void;
		function securityErrorHandler( e:SecurityErrorEvent ):void
	}
}