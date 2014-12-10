package com.cloudnet.common.mvc.model.business
{
	import com.cloudnet.common.interfaces.ISocketHandle;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.Timer;

	public class SocketDelegate
	{
		private var _socket:Socket;
		private var retryTimer:Timer = new Timer( 1000 );
		private var ip:String;
		private var port:int;
		
		public function get socket():Socket
		{
			return _socket;
		}
		
		public function SocketDelegate(proxy:ISocketHandle)
		{
			_socket = new Socket(); 
			_socket.addEventListener( Event.CONNECT, proxy.connectionHandler );
			_socket.addEventListener( Event.CLOSE, proxy.closedHandler );
			_socket.addEventListener( IOErrorEvent.IO_ERROR, proxy.socketFailureHandler );
			_socket.addEventListener( SecurityErrorEvent.SECURITY_ERROR, proxy.securityErrorHandler );
			_socket.addEventListener( ProgressEvent.SOCKET_DATA, proxy.socketDataHandler );
			
		}
	}
}