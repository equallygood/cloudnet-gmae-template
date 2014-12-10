package com.cloudnet.game.sicbo.view
{
	import com.cloudnet.common.events.CrossDataEvent;
	import com.cloudnet.common.vo.CrossData;
	import com.cloudnet.game.sicbo.model.LoaderInfoProxy;
	import com.cloudnet.game.sicbo.view.scenes.PlayGameScene;
	
	import flash.events.Event;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 遊戲場景 Mediator
	 * 用來串接 Play Game Scene 與 PureMVC 架構 
	 * @author Administrator
	 * 
	 */	
	public class PlayGameSceneMediator extends Mediator
	{
		public static const NAME:String = "GameSceneMediator";
		
		public function PlayGameSceneMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			var l:CrossDataEvent
			playGameScene.addEventListener('go_to_lobby',goToLobby);
		}
		
		/**
		 * 處理場景交互並派發跨SWF事件 
		 * @param e
		 * 
		 */		
		protected function goToLobby(e:Event):void
		{
			var data:CrossData=new CrossData();
			data.status = CrossData.BACK_LOBBY;
			data.data = "Hello Lobby";
			var message:CrossDataEvent = new CrossDataEvent(CrossDataEvent.FROM_GAME);
			message.data = data;
			loaderInfoProxy.dispatchEvent(message);
		}
		
		/**
		 * 取得場景參照 
		 * @return 
		 * 
		 */
		protected function get playGameScene():PlayGameScene
		{
			return viewComponent as PlayGameScene;
		}
		
		/**
		 * 取得LoaderInfoProxy
		 * @see com.cloudnet.game.sicbo.model.LoaderInfoProxy
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