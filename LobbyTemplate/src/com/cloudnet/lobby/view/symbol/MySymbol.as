package com.cloudnet.lobby.view.symbol
{
	import com.cloudnet.common.core.SymbolSprite;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * SWF Symbol使用範例 
	 * @author Administrator
	 * 
	 */	
	public class MySymbol extends SymbolSprite
	{
		private var _hello:MovieClip;
		private var _cloud:MovieClip;
		
		public function MySymbol(viewComponent:MovieClip)
		{
			super(viewComponent);
		}
		/**
		 * 取得與指定UI參照 
		 * 
		 */		
		override protected function configUI():void
		{
			super.configUI();
			
			_hello = _symbol.getChildByName("hello") as MovieClip;
			_cloud = _symbol.getChildByName("cloud") as MovieClip;
		}
		
		/**
		 * 配置UI交互事件 
		 * 
		 */		
		override protected function configEvent():void
		{
			_hello.addEventListener(MouseEvent.CLICK,clickHandler);
			_cloud.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		/**
		 * 處理UI交互事件 
		 * @param event
		 * 
		 */		
		protected function clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
		}
		
		/**
		 * 銷毀相關物件與事件 
		 * 
		 */		
		override public function destroy():void
		{
			trace("MyComponent destroy");
			_hello.removeEventListener(MouseEvent.CLICK,clickHandler);
			_cloud.removeEventListener(MouseEvent.CLICK,clickHandler);
			
			super.destroy();
		}
	}
}