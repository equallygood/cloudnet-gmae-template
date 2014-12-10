package server
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	
	public class SocketService extends EventDispatcher
	{
		public const TYPE_AMF:int = 0;
		public const TYPE_STRING:int = 1;
		
		private var socket:Socket;
		private var log:Function;
		
		public function SocketService( socket:Socket, loggingFunction:Function )
		{
			this.socket = socket;
			socket.addEventListener( ProgressEvent.SOCKET_DATA, handshakeHandler );
			socket.addEventListener( Event.CLOSE, onClientClose );
			socket.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			
			log = loggingFunction;
			log( "Connected to " + socket.remoteAddress + ":" + socket.remotePort );			
		}
		private function handshakeHandler( event:ProgressEvent ):void
		{
			var socket:Socket = event.target as Socket;
			
			//Read the message from the socket
			var message:String = socket.readUTFBytes( socket.bytesAvailable );
			log( "Received: " + message);
			if( message == "<policy-file-request/>" )
			{
				var policy:String = '<cross-domain-policy><allow-access-from domain="*" to-ports="8087" /></cross-domain-policy>\x00';
				socket.writeUTFBytes( policy );
				socket.flush();
				socket.close();
				log("Sending policy: " + policy);
			} else if ( message == "BEGIN" )
			{
				socket.removeEventListener( ProgressEvent.SOCKET_DATA, handshakeHandler );
				socket.addEventListener( ProgressEvent.SOCKET_DATA, socketDataHandler );
				socket.writeUTFBytes( "READY" );
				socket.flush();
			} 
		}
		
		private var messageLength:int = 0;
		
		public function socketDataHandler(event:ProgressEvent):void
		{
			try
			{
				while( socket.bytesAvailable >= 4 )//while there is at least enough data to read the message size header
				{
					if( messageLength == 0 ) //is this the start of a new message block?
					{
						messageLength = socket.readUnsignedInt(); //read the message length header
					}
					
					if( messageLength <= socket.bytesAvailable ) //is there a full message in the socket?
					{
						trace(messageLength);
						
						var utfMessage:String = socket.readUTF();
						log( socket.remoteAddress + ":" + socket.remotePort + " sent " + utfMessage );
						reply( "Echo: " + utfMessage );
						
						messageLength = 0; //finished reading this message
					}
					else { //The current message isn't complete -- wait for the socketData event and try again
						reply( "Partial message: " + socket.bytesAvailable + " of " + messageLength );
						break;
					}
				}
			}
			catch ( e:Error )
			{
				log( e );
			}			
		}
		
		/*public function socketDataHandler(event:ProgressEvent):void
		{
			try
			{
				while( socket.bytesAvailable >= 4 )//while there is at least enough data to read the message size header
				{
					if( messageLength == 0 ) //is this the start of a new message block?
					{
						messageLength = socket.readUnsignedInt(); //read the message length header
					}
					
					if( messageLength <= socket.bytesAvailable ) //is there a full message in the socket?
					{
						trace(messageLength);
						
						var typeFlag:int = socket.readInt(); //read the message type header
						
						//Read the message based on the type
						if( typeFlag == TYPE_AMF ) //AMF object
						{
							var dataMessage:SerializableObject = socket.readObject() as SerializableObject;
							log( socket.remoteAddress + ":" + socket.remotePort + " sent " + dataMessage.toString() );
							reply( "Echo: " + dataMessage.toString() );
						}
						else if ( typeFlag == TYPE_STRING ) //UTF string
						{
							var utfMessage:String = socket.readUTF();
							log( socket.remoteAddress + ":" + socket.remotePort + " sent " + utfMessage );
							reply( "Echo: " + utfMessage );
						}
						messageLength = 0; //finished reading this message
					}
					else { //The current message isn't complete -- wait for the socketData event and try again
						reply( "Partial message: " + socket.bytesAvailable + " of " + messageLength );
						break;
					}
				}
			}
			catch ( e:Error )
			{
				log( e );
			}			
		}*/
		
		private function reply( message:String ):void
		{
			if( message != null )
			{
				socket.writeUTFBytes( message );
				socket.flush();
				log( "Sending: " + message );
			}						
		}
		
		private function onClientClose( event:Event ):void
		{
			var socket:Socket = event.target as Socket;
			log( "Connection to client " + socket.remoteAddress + ":" + socket.remotePort + " closed." );
			dispatchEvent( new Event( Event.CLOSE ) );
		}
		
		private function onIOError( errorEvent:IOErrorEvent ):void
		{
			log( "IOError: " + errorEvent.text );
			socket.close();
		}
		
		public function get closed():Boolean
		{
			return socket.connected;
		}
	}
}