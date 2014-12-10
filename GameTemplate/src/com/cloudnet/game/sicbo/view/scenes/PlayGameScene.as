package com.cloudnet.game.sicbo.view.scenes
{
	import com.cloudnet.common.events.SceneEvent;
	import com.cloudnet.common.scenes.Scene;
	import com.cloudnet.common.utils.AnimSpriteUtil;
	import com.cloudnet.common.utils.FunMuxUtil;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.display.ContentDisplay;
	
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fw.anim.AnimSprite;
	
	import org.casalib.display.CasaBitmap;
	
	/**
	 * 遊戲場景 
	 * @author Administrator
	 * 
	 */
	public class PlayGameScene extends Scene
	{
		private var _runningBoy:AnimSprite;
		private var _goSelectTable:Button;
		private var _goLobby:Button;
		
		public function PlayGameScene()
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
			
			var content:Bitmap = ContentDisplay(LoaderMax.getContent("sicbo_screen_back")).getChildAt(0) as Bitmap;
			var back:CasaBitmap = new CasaBitmap(content.bitmapData.clone());
			addChild(back);
			
			var sheet:Bitmap = ContentDisplay(LoaderMax.getContent("walking_guy")).getChildAt(0) as Bitmap;
			var sheetData:String = LoaderMax.getContent("walking_guy_json");
			
			_runningBoy=AnimSpriteUtil.createSpriteSheetAnim(sheet.bitmapData,sheetData,12);
			
			_runningBoy.x=300;
			_runningBoy.y=300;
			addChild(_runningBoy);
			
			FunMuxUtil.getInstance().addFun(frameUpdate);
			
			_goSelectTable = new Button();
			_goSelectTable.label = "Select Table";
			_goSelectTable.setSize(200,100);
			_goSelectTable.move(100,150);
			addChild(_goSelectTable);
			
			_goLobby = new Button();
			_goLobby.label = "Go to Lobby";
			_goLobby.setSize(200,100);
			_goLobby.move(100,260);
			addChild(_goLobby);
		}
		
		/**
		 * 更新Sprite Sheet Animation 
		 * @param e
		 * 
		 */
		override protected function frameUpdate(e:Event):void
		{
			super.frameUpdate(e);
			
			_runningBoy.updateAnimation();
		}
		
		/**
		 * 配置交互事件 
		 * 
		 */
		override protected function configEvent():void
		{
			_goSelectTable.addEventListener(MouseEvent.CLICK,clickHandler);
			_goLobby.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		/**
		 * 用戶交互處理 
		 * @param e
		 * 
		 */
		protected function clickHandler(e:MouseEvent):void
		{
			if(e.currentTarget==_goSelectTable)
			{
				var event:SceneEvent=new SceneEvent(SceneEvent.SCENE_CHANGE,true);
				event.name = GameSceneNames.SELECT_TABLE;
				this.dispatchEvent(event);
				
			}
			else if(e.currentTarget == _goLobby)
			{
				this.dispatchEvent(new Event('go_to_lobby'));
			}
			
		}
		
		/**
		 * 銷毀場景相關物件與事件 
		 * 
		 */
		override public function destroy():void 
		{
			super.destroy();
			
			FunMuxUtil.getInstance().removeFun(frameUpdate);
			_goSelectTable.removeEventListener(MouseEvent.CLICK,clickHandler);
			_goLobby.removeEventListener(MouseEvent.CLICK,clickHandler);
			
			trace(this,"destroy");
		}
	}
}