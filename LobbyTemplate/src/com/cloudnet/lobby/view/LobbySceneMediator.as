package com.cloudnet.lobby.view
{
	import com.cloudnet.common.events.CrossDataEvent;
	import com.cloudnet.common.mvc.model.CommonNotification;
	import com.cloudnet.common.vo.CrossData;
	import com.cloudnet.lobby.LobbyNotification;
	import com.cloudnet.lobby.model.LoaderInfoProxy;
	import com.cloudnet.lobby.view.scenes.LobbyScene;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	/**
	 * 大廳場景 Mediator
	 * 用來串接 Lobby Scene 與 PureMVC 架構
	 * @author Administrator
	 * 
	 */	
	public class LobbySceneMediator extends Mediator
	{
		public static const NAME:String = "LobbySceneMediator";
		/**
		 * 
		 * @param viewComponent 大廳場景
		 * 
		 */		
		public function LobbySceneMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			lobbyScene.addEventListener('go_to_game',goToGame);
		}
		/**
		 * 使用CrossDataEvent觸發載入器載入遊戲 
		 * @see com.cloudnet.common.events.CrossDataEvent
		 * @param e
		 * 
		 */		
		protected function goToGame(e:Event):void
		{
			var data:CrossData=new CrossData();
			data.status = CrossData.GAME_CHANGE;
			data.data = "table_001";
			var message:CrossDataEvent = new CrossDataEvent(CrossDataEvent.FROM_LOBBY);
			message.data = data;
			loaderInfoProxy.dispatchEvent(message);
		}
		/**
		 * 定義感興趣的通知清單 
		 * @return 
		 * 
		 */		
		override public function listNotificationInterests():Array 
		{
			return [
				LobbyNotification.PUREMVC_INIT_COMPLETE,
				CommonNotification.RESOURCE_LOADER_COMPLETE
			];
		}
		/**
		 * 處理感興趣的通知 
		 * @param note
		 * 
		 */		
		override public function handleNotification( note:INotification ):void 
		{
			var notificationName:String = note.getName();
			var data:Object = note.getBody();
			
			switch ( notificationName ) 
			{
				case LobbyNotification.PUREMVC_INIT_COMPLETE:
					
					
					break;
				case CommonNotification.RESOURCE_LOADER_COMPLETE:
					
					
					break;
			}
		}
		/**
		 * 取得大廳場景 
		 * @return 
		 * 
		 */		
		protected function get lobbyScene():LobbyScene
		{
			return viewComponent as LobbyScene;
		}
		/**
		 * 取得LoaderInfoProxy
		 * @see com.cloudnet.lobby.model.LoaderInfoProxy
		 * @see http://help.adobe.com/zh_TW/FlashPlatform/reference/actionscript/3/flash/display/LoaderInfo.html 
		 * @return 
		 * 
		 */		
		protected function get loaderInfoProxy():LoaderInfoProxy
		{
			var loaderInfo:LoaderInfoProxy = LoaderInfoProxy( facade.retrieveProxy( LoaderInfoProxy.NAME ) );
			return loaderInfo;
		}
	}
}