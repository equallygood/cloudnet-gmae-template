package com.cloudnet.common.mvc.model
{
	public class CommonNotification
	{
		public static const RESOURCE_LOADER_PROGRESS:String 		= "resource_loader_progress";
		public static const RESOURCE_LOADER_COMPLETE:String			= "resource_loader_complete";
		public static const RESOURCE_LOADER_ERROR:String			= "resource_loader_error";
		
		public static const LANGUAGE_COMPLETE:String				= "language_complete";
		
		public static const CONNECTION_SOCKET:String				= "connection_socket";
		public static const CONNECTION_CLOSED_BY_SERVER:String		= "Connection_closed_by_server";
		public static const CONNECTION_CLOSED_BY_CLIENT:String		= "Connection_closed_by_clilent";
		public static const RECEIVE_SOCKET_MESSAGE:String			= "receive_socket_message";
		
		public function CommonNotification()
		{
		}
	}
}