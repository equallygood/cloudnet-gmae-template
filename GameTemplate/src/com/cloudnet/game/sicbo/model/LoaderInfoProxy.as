package com.cloudnet.game.sicbo.model
{
	import com.cloudnet.common.events.CrossDataEvent;
	import com.cloudnet.common.vo.CrossData;
	import com.cloudnet.game.sicbo.GameNotification;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TextEvent;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * 處理載入器與遊戲之間的通訊
	 * @see http://help.adobe.com/zh_TW/FlashPlatform/reference/actionscript/3/flash/display/LoaderInfo.html  
	 * @author Administrator
	 * 
	 */	
	public class LoaderInfoProxy extends Proxy
	{
		public static const NAME:String = "GameLoaderInfoProxy";
		
		private var _rootLoaderInfo:LoaderInfo;
		private var _loaderInfo:LoaderInfo;
		private var _shared:EventDispatcher;
		
		/**
		 * 可從flashvars取得embed SWF時所帶入的資訊
		 * @return 
		 * 
		 */
		public function get userName():String
		{
			return rootLoaderInfo.parameters.userName;
		}
		
		/**
		 * 可從flashvars取得embed SWF時所帶入的資訊 
		 * @return 
		 * 
		 */
		public function get uid():String
		{
			return rootLoaderInfo.parameters.uid;
		}
		
		/**
		 * stage.root.loaderInfo
		 * @return 
		 * 
		 */
		public function get rootLoaderInfo():LoaderInfo
		{
			return _rootLoaderInfo;
		}
		
		/**
		 * 
		 * 指定LoaderInfo並透過 sharedEvents監聽跨SWF事件
		 * @param rootLoaderInfo stage.root.loaderInfo
		 * @param loaderInfo lobby.loaderInfo
		 * @see http://help.adobe.com/zh_TW/FlashPlatform/reference/actionscript/3/flash/display/LoaderInfo.html
		 * @see com.cloudnet.common.events.CrossDataEvent
		 * 
		 */
		public function LoaderInfoProxy(rootLoaderInfo:LoaderInfo, loaderInfo:LoaderInfo)
		{
			super(NAME);
			_rootLoaderInfo = rootLoaderInfo;
			_loaderInfo = loaderInfo;
			
			_shared =_loaderInfo.sharedEvents;
			
			_shared.addEventListener(CrossDataEvent.FROM_LOADER,fromLoader);
		}
		
		/**
		 * 派發跨SWF事件
		 * @param event CrossDataEvent
		 * 
		 */
		public function dispatchEvent(event:CrossDataEvent):void
		{
			_shared.dispatchEvent(event);
		}
		
		/**
		 * 處理來自載入器的事件 
		 * @param event
		 * @see com.cloudnet.common.events.CrossDataEvent
		 * 
		 */
		private function fromLoader(event:CrossDataEvent):void
		{
			var status:String = event.data.status;
			
			switch ( status ) 
			{
				case CrossData.GAME_RESOURCE:
					
					this.sendNotification(GameNotification.GAME_RESOURCE_PATH,event.data.data);
					
					break;
			}
		}
		
	}
}