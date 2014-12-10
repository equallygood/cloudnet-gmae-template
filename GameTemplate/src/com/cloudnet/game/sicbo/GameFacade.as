package com.cloudnet.game.sicbo
{
	import com.cloudnet.game.sicbo.controller.GameStartupCommand;
	
	import flash.sensors.Accelerometer;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * 你只需繼承Facade類創建一個具體的Facade類就可以實現整個MVC模式 
	 * @author Administrator
	 * 
	 */
	public class GameFacade extends Facade
	{
		
		public function GameFacade()
		{
			super();
		}
		
		/**
		 * 使用單例取得Facade instance參照 
		 * @return 
		 * 
		 */
		public static function getInstance() : GameFacade 
		{
			if ( instance == null ) instance = new GameFacade( );
			return instance as GameFacade;
		}
		
		/**
		 * 覆載initializeController並註冊命令
		 * 
		 */
		override protected function initializeController( ) : void 
		{
			trace("initializeController");
			super.initializeController(); 
			
			registerCommand( GameNotification.GAME_STARTUP, GameStartupCommand );
		}
		
		/**
		 * 帶入文件類別instance參照並傳送啟動通知
		 * @param main document class
		 * 
		 */
		public function startup( app:Game ):void
		{
			sendNotification( GameNotification.GAME_STARTUP, app);
		}
	}
}