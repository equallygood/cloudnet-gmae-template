package com.cloudnet.lobby
{
	import com.cloudnet.lobby.controller.LobbyStartupCommand;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * 你只需繼承Facade類創建一個具體的Facade類就可以實現整個MVC模式 
	 * @author Administrator
	 * 
	 */	
	public class LobbyFacade extends Facade
	{
		public function LobbyFacade()
		{
			super();
		}
		
		/**
		 * 使用單例取得Facade instance參照 
		 * @return 
		 * 
		 */		
		public static function getInstance() : LobbyFacade 
		{
			if ( instance == null ) instance = new LobbyFacade( );
			return instance as LobbyFacade;
		}
		
		/**
		 * 覆載initializeController並註冊命令
		 * 
		 */		
		override protected function initializeController( ) : void 
		{
			super.initializeController(); 
			
			registerCommand( LobbyNotification.LOBBY_STARTUP, LobbyStartupCommand );
		}
		
		/**
		 * 帶入文件類別instance參照並傳送啟動通知
		 * @param main document class
		 * 
		 */		
		public function startup( main:Lobby ):void
		{
			sendNotification( LobbyNotification.LOBBY_STARTUP, main);
		}
		
	}
}