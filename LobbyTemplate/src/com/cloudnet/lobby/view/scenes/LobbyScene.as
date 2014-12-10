package com.cloudnet.lobby.view.scenes
{
	import com.cloudnet.common.events.SceneEvent;
	import com.cloudnet.common.scenes.Scene;
	import com.cloudnet.common.utils.AnimSpriteUtil;
	import com.cloudnet.common.utils.FunMuxUtil;
	import com.cloudnet.common.utils.ResourceUtil;
	import com.cloudnet.lobby.view.symbol.MySymbol;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fl.controls.Button;
	
	import fw.anim.AnimSprite;
	
	import org.casalib.core.IDestroyable;
	import org.casalib.display.CasaBitmap;
	import org.casalib.display.CasaSprite;

	/**
	 * 大廳場景 
	 * @author Administrator
	 * 
	 */	
	public class LobbyScene extends Scene
	{
		private var _pig:AnimSprite;
		private var _goCampaign:Button;
		private var _goGame:Button;
		private var _goSocketDemo:Button;
		
		public function LobbyScene()
		{
			super();
		}
		/**
		 * 配置場景UI 
		 * 
		 */		
		override protected function configUI():void
		{
			super.configUI();
			
			
			var back:CasaBitmap = ResourceUtil.getBitmapByName("lobby_back");
			addChild(back);
			
			var component:MovieClip = ResourceUtil.getSymbolByName("flash_symbol","MyComponent");
			var my:MySymbol = new MySymbol(component);
			addChild(my);
			
			_pig = ResourceUtil.getSpriteSheetByName("pig_walk","pig_walk_json");
			
			_pig.x=300;
			_pig.y=300;
			addChild(_pig);
			
			FunMuxUtil.getInstance().addFun(frameUpdate);
			
			_goCampaign = new Button();
			_goCampaign.label = "Campaign";
			_goCampaign.setSize(200,100);
			_goCampaign.move(100,150);
			addChild(_goCampaign);
			
			_goGame = new Button();
			_goGame.label = "Play Now !!!";
			_goGame.setSize(200,100);
			_goGame.move(100,260);
			addChild(_goGame);
			
			_goSocketDemo = new Button();
			_goSocketDemo.label = "Socket Demo";
			_goSocketDemo.setSize(200,100);
			_goSocketDemo.move(100,370);
			addChild(_goSocketDemo);
			
		}
		/**
		 * 用戶交互處理 
		 * @param e
		 * 
		 */		
		protected function clickHandler(e:MouseEvent):void
		{
			var event:SceneEvent;
			
			if(e.currentTarget==_goCampaign)
			{
				event=new SceneEvent(SceneEvent.SCENE_CHANGE,true);
				
				event.name = LobbySceneNames.CAMPAIGN;
				this.dispatchEvent(event);
			}
			else if(e.currentTarget == _goGame)
			{
				this.dispatchEvent(new Event('go_to_game'));
			}
			else if(e.currentTarget == _goSocketDemo)
			{
				event=new SceneEvent(SceneEvent.SCENE_CHANGE,true);
				
				event.name = LobbySceneNames.SOCKET_DEMO;
				this.dispatchEvent(event);
			}
			
		}
		/**
		 * 更新Sprite Sheet Animation 
		 * @param e
		 * 
		 */		
		override protected function frameUpdate(e:Event):void
		{
			super.frameUpdate(e);
			
			_pig.updateAnimation();
		}
		/**
		 * 配置交互事件 
		 * 
		 */		
		override protected function configEvent():void
		{
			_goCampaign.addEventListener(MouseEvent.CLICK,clickHandler);
			_goGame.addEventListener(MouseEvent.CLICK,clickHandler);
			_goSocketDemo.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		/**
		 * 銷毀場景相關物件與事件 
		 * 
		 */		
		override public function destroy():void 
		{
			super.destroy();
			FunMuxUtil.getInstance().removeFun(frameUpdate);
			_goCampaign.removeEventListener(MouseEvent.CLICK,clickHandler);
			_goGame.removeEventListener(MouseEvent.CLICK,clickHandler);
			trace("LobbyScene destroy");
		}
	}
}