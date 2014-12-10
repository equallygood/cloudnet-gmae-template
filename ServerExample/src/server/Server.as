package server
{
	import flash.events.Event;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.registerClassAlias;
	
	public class Server
	{
		private var serverSocket:ServerSocket;
		private var clientSockets:Array = new Array();
		private var log:Function;
				
		public function Server( loggingFunction:Function )
		{
			registerClassAlias( "SerializableObject", SerializableObject );
			log = loggingFunction;
			try
			{
				// Create the server socket
				serverSocket = new ServerSocket();
				
				// Add the event listener
				serverSocket.addEventListener( Event.CONNECT, connectHandler );
				serverSocket.addEventListener( Event.CLOSE, onClose );
				
				// Bind to local port 8087
				serverSocket.bind( 8087, "127.0.0.1" );
				
				// Listen for connections
				serverSocket.listen();
				log( "Listening on " + serverSocket.localPort );
			}
			catch(e:Error)
			{
				log(e);
			}
		}

		public function connectHandler(event:ServerSocketConnectEvent):void
		{
			//The socket is provided by the event object
			 var socketServicer:SocketService = new SocketService( event.socket, log );
			socketServicer.addEventListener( Event.CLOSE, onClientClose );
			clientSockets.push( socketServicer ); //maintain a reference to prevent premature garbage collection
		}

		
		private function onClientClose( event:Event ):void
		{
			//Nullify references to closed sockets
			for each( var servicer:SocketService in clientSockets )
			{
				if( servicer.closed ) servicer = null;
			}
		}


		private function onClose( event:Event ):void
		{
			log( "Server socket closed by OS." );
		}
}}