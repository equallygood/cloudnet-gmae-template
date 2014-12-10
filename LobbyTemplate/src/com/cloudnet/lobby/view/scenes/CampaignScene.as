package com.cloudnet.lobby.view.scenes
{
	import com.cloudnet.common.events.SceneEvent;
	import com.cloudnet.common.scenes.Scene;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.display.ContentDisplay;
	
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaBitmap;
	/**
	 * 促銷活動場景 
	 * @author Administrator
	 * 
	 */	
	public class CampaignScene extends Scene
	{
		
		private var _goLobby:Button;
		
		public function CampaignScene()
		{
			super();
		}
		/**
		 * 配置UI 
		 * 
		 */		
		override protected function configUI():void
		{
			super.configUI();
			
			var content:Bitmap = ContentDisplay(LoaderMax.getContent("campaign_back")).getChildAt(0) as Bitmap;
			var back:CasaBitmap = new CasaBitmap(content.bitmapData.clone());
			addChild(back);
			
			_goLobby = new Button();
			_goLobby.label = "Lobby";
			_goLobby.setSize(200,100);
			_goLobby.move(100,150);
			addChild(_goLobby);
		}
		/**
		 * 處理用戶交互 
		 * @param e
		 * 
		 */		
		protected function clickHandler(e:MouseEvent):void
		{
			var event:SceneEvent=new SceneEvent(SceneEvent.SCENE_CHANGE,true);
			event.name = LobbySceneNames.LOBBY;
			this.dispatchEvent(event);
		}
		/**
		 * 配置交互事件 
		 * 
		 */		
		override protected function configEvent():void
		{
			_goLobby.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		/**
		 * 銷毀相關物件與事件 
		 * 
		 */		
		override public function destroy():void 
		{
			super.destroy();
			_goLobby.removeEventListener(MouseEvent.CLICK,clickHandler);
			trace("CampaignScene destroy");
		}
	}
}