package com.cloudnet.common.mvc.model
{
	import com.cloudnet.common.interfaces.ISocketHandle;
	import com.cloudnet.common.mvc.model.business.SocketDelegate;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class SocketProxy extends Proxy implements ISocketHandle
	{
		public static const NAME:String = "SocketProxy";
		
		private var _delegate:SocketDelegate;
		private var _ip:String;
		private var _port:int;
		private var _retryTimer:Timer = new Timer( 1000 );
		
		public function SocketProxy()
		{
			super(NAME);
			
			_delegate = new SocketDelegate(this);
		}
		
		//發送
		public function sendString( text:String ):void
		{
			var bytes:ByteArray = new ByteArray();
			//bytes.writeInt( TYPE_STRING ); //message type
			bytes.writeUTF(text);
			bytes.position = 0;
			
			try{
				//寫長度
				_delegate.socket.writeUnsignedInt( bytes.length );
				
				//寫入字符串到 socket
				_delegate.socket.writeBytes( bytes );
				
				//確保它被送出
				_delegate.socket.flush();
				
			} catch ( e:Error )
			{
				trace( e.toString() );
			}
			
			trace( "Sending: " + text );
		}
		/**
		 *  
		 * @param ip
		 * @param port
		 * 
		 */		
		public function connect(ip:String, port:int):void
		{
			_ip = ip;
			_port = port;
			//連接到服務器
			_retryTimer.addEventListener( TimerEvent.TIMER, connectToServer );
			_retryTimer.start();
		}
		
		public function close():void
		{
			sendNotification(CommonNotification.CONNECTION_CLOSED_BY_CLIENT, "Connection Closed by Client");
			_delegate.socket.close();
		}
		
		private function connectToServer( event:TimerEvent ):void
		{
			try
			{
				//嘗試連接
				_delegate.socket.connect( _ip, _port );			
			}
			catch( e:Error )
			{
				trace( e.toString() );
			}			
		}
		
		public function connectionHandler(e:Event):void
		{
			sendNotification(CommonNotification.CONNECTION_SOCKET, "Connection socket");
			
			_delegate.socket.writeUTFBytes( "BEGIN" );
			_delegate.socket.flush();
			
			//Stop retry timer
			_retryTimer.removeEventListener( TimerEvent.TIMER, connectToServer );
			_retryTimer.stop();
		}
		
		public function socketDataHandler(e:ProgressEvent):void
		{
			try
			{
				//從Socket讀UTF字符串
				var message:String = _delegate.socket.readUTFBytes( _delegate.socket.bytesAvailable );
				trace( "Received: " + message ); 
				sendNotification(CommonNotification.RECEIVE_SOCKET_MESSAGE,message);
			}
			catch( e:Error )
			{
				trace( e.toString() );
			}
		}
		
		public function closedHandler(e:Event):void
		{
			//log("Connection closed by server.");
			sendNotification(CommonNotification.CONNECTION_CLOSED_BY_SERVER,"Connection Closed by Server");
		}
		
		public function socketFailureHandler(e:IOErrorEvent):void
		{
			//log( error.text );
		}
		
		public function securityErrorHandler(e:SecurityErrorEvent):void
		{
			//log( event.text );
		}
	}
}