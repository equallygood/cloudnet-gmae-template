package com.cloudnet.common.vo
{
	import com.cloudnet.common.utils.StringUtil;

	public class CrossData
	{
		public static const GAME_INIT:String 		= "game_init";
		public static const GAME_READY:String 		= "game_ready";
		public static const GAME_CHANGE:String 		= "game_change";
		public static const GAME_RESOURCE:String	= "game_resource";
		
		public static const BACK_LOBBY:String		= "back_lobby";
		
		public static const LOBBY_INIT:String 		= "lobby_init";
		public static const LOBBY_READY:String 		= "lobby_ready";
		
		public static const LOBBY_RESOURCE:String	= "lobby_resource";
		
		
		public var data:String = "Hello CloudNet";
		public var status:String = "lobby_ready";
		
		public function CrossData()
		{
		}

		public function toString():String
		{
			return StringUtil.formatToString(this,'data','status');
		}
	}
}