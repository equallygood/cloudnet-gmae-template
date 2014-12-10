package com.cloudnet.game.sicbo.view.scenes
{
	import com.cloudnet.common.events.SceneEvent;
	import com.cloudnet.common.scenes.Scene;
	import com.cloudnet.game.sicbo.events.SelectTableEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.display.ContentDisplay;
	
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaBitmap;
	
	/**
	 * 選桌場景 
	 * @author Administrator
	 * 
	 */
	public class SelectTableScene extends Scene
	{
		private var _tableBtn:Button;
		
		public function SelectTableScene()
		{
			super();
		}
		
		/**
		 * 配置場景UI 
		 * 
		 */
		override protected function configUI():void
		{
			
			var content:Bitmap = ContentDisplay(LoaderMax.getContent("sicbo_back")).getChildAt(0) as Bitmap;
			var back:CasaBitmap = new CasaBitmap(content.bitmapData.clone());
			addChild(back);
			
			_tableBtn=new Button();
			_tableBtn.label="第01桌";
			_tableBtn.setSize(100,100);
			addChild(_tableBtn);
		}
		
		/**
		 * 配置交互事件 
		 * 
		 */
		override protected function configEvent():void
		{
			_tableBtn.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		/**
		 * 用戶交互處理 
		 * @param e
		 * 
		 */
		
		protected function clickHandler(e:MouseEvent):void
		{
			var event:SceneEvent=new SceneEvent(SceneEvent.SCENE_CHANGE,true);
			event.name = GameSceneNames.PLAY_GAME;
			event.data = "1";
			dispatchEvent(event);
		}
		
		/**
		 * 銷毀場景相關物件與事件 
		 * 
		 */
		override public function destroy():void 
		{
			super.destroy();
			_tableBtn.removeEventListener(MouseEvent.CLICK,clickHandler);
		}
	}
}