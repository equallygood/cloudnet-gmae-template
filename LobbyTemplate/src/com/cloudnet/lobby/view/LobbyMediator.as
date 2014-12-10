package com.cloudnet.lobby.view
{
	import com.cloudnet.common.events.CrossDataEvent;
	import com.cloudnet.common.events.SceneEvent;
	import com.cloudnet.common.mvc.model.CommonNotification;
	import com.cloudnet.common.mvc.model.JSONLoaderProxy;
	import com.cloudnet.common.mvc.model.LanguageProxy;
	import com.cloudnet.common.mvc.model.ResourceProxy;
	import com.cloudnet.common.mvc.model.XMLLoaderProxy;
	import com.cloudnet.common.scenes.Scene;
	import com.cloudnet.common.utils.AnimSpriteUtil;
	import com.cloudnet.common.utils.FunMuxUtil;
	import com.cloudnet.common.vo.CrossData;
	import com.cloudnet.lobby.Lobby;
	import com.cloudnet.lobby.LobbyNotification;
	import com.cloudnet.lobby.model.LoaderInfoProxy;
	import com.cloudnet.lobby.view.scenes.CampaignScene;
	import com.cloudnet.lobby.view.scenes.LobbyScene;
	import com.cloudnet.lobby.view.scenes.LobbySceneNames;
	import com.cloudnet.lobby.view.scenes.SocketDemoScene;
	import com.greensock.TweenMax;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.display.ContentDisplay;
	import com.reintroducing.sound.SoundManager;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.Socket;
	import flash.net.URLRequest;
	
	import fw.anim.AnimSprite;
	import fw.anim.AnimTextureSheet;
	import fw.anim.TileSheetHelper;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * Lobby Mediator
	 * 用來串接 Lobby(document class) 與 PureMVC 架構 
	 * @author Administrator
	 * 
	 */	
	public class LobbyMediator extends Mediator
	{
		public static const NAME:String = "MainMediator";
		
		private var currentScene:Scene
		private var currentMediator:Mediator;
		private var currentMediatorName:String;
		
		/**
		 * 建構子
		 * 配置UI事件 
		 * @param viewComponent
		 * 
		 */		
		public function LobbyMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			lobby.addEventListener(Event.ENTER_FRAME,FunMuxUtil.getInstance().invoke);
			lobby.addEventListener(SceneEvent.SCENE_CHANGE,changeSceneHandler);
			
		}
		
		/**
		 * 處理切換場景 
		 * @param e
		 * 
		 */		
		protected function changeSceneHandler(e:SceneEvent):void
		{
			var scene:String = e.name;
			
			switch ( scene ) 
			{
				case LobbySceneNames.CAMPAIGN:
					
					showScene(CampaignScene,CampaignSceneMediator);
					
					break;
				case LobbySceneNames.LOBBY:
					
					showScene(LobbyScene,LobbySceneMediator);
					
					break;
				case LobbySceneNames.SOCKET_DEMO:
					
					showScene(SocketDemoScene,SocketDemoSceneMediator);
					
					break;
			}
			
		}
		/**
		 * 定義感興趣通知清單 
		 * @return 
		 * 
		 */		
		override public function listNotificationInterests():Array 
		{
			return [
				LobbyNotification.PUREMVC_INIT_COMPLETE,
				LobbyNotification.LOBBY_RESOURCE_PATH,
				CommonNotification.RESOURCE_LOADER_PROGRESS,
				CommonNotification.RESOURCE_LOADER_COMPLETE,
				CommonNotification.RESOURCE_LOADER_ERROR,
				CommonNotification.LANGUAGE_COMPLETE
			];
		}
		/**
		 * 處理感興趣通知 
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
					
					var crossData:CrossData=new CrossData();
					crossData.status = CrossData.LOBBY_INIT;
					
					var event:CrossDataEvent=new CrossDataEvent(CrossDataEvent.FROM_LOBBY);
					event.data = crossData;
					loaderInfoProxy.dispatchEvent(event);
					
					demoWebAPI();
					
					break;
				case LobbyNotification.LOBBY_RESOURCE_PATH:
					
					resourceProxy.load(data.toString(),"lobby_resource_doc");
					
					break;
				case CommonNotification.RESOURCE_LOADER_PROGRESS:
					
					var progress:Number=Math.round(Number(data)*100);
					
					break;
				case CommonNotification.RESOURCE_LOADER_COMPLETE:
					
					parseSoundData();
					showScene(LobbyScene,LobbySceneMediator);
					
					//trace(resourceProxy.resourceData.Languages);
					
					languageProxy.initializeLang(resourceProxy.resourceData.Languages[0]);
					
					/*
					<Languages prependURLs="http://localhost:8081/cloudnet/">
					<Lang locale="zh-TW" url="lang/lobby/lobby_zh_TW.xml" />
					<Lang locale="zh-CN" url="lang/lobby/lobby_zh_CN.xml" />
					<Lang locale="en" url="lang/lobby/lobby_en.xml" />
					</Languages>
					*/
					
					break;
				case CommonNotification.LANGUAGE_COMPLETE:
					
					//Demo Get String
					trace("Demo Get String",languageProxy.getStringByID("IDS_GREETINGS"));
					
					break;
			}
		}
		/**
		 * 解析Sound Data並使用SoundManager加入外部Sound 
		 * 
		 */		
		protected function parseSoundData():void
		{
			var list:XMLList = resourceProxy.resourceData.LoaderMax.MP3Loader;
			var sound:Sound;
			var name:String;
			var manager:SoundManager = SoundManager.getInstance();
			for each(var prop:XML in list)
			{
				name = prop.@name;
				sound = LoaderMax.getContent(name) as Sound;
				if(sound)
				{
					manager.addPreloadedSound(sound,name);
				}
			}
			//demo
			manager.playSound('here_we_go_mp3',1,0,999);
		}
		/**
		 * 示範Web API 
		 * 
		 */		
		protected function demoWebAPI():void
		{
			var request_xml:URLRequest = new URLRequest("resource/config/games/poker.xml");
			xmlProxy.load(request_xml);
			
			var request_json:URLRequest = new URLRequest("webapi/hello.php");
			josnProxy.load(request_json);
		}
		/**
		 * 關閉場景 
		 * 
		 */		
		protected function closeScene():void
		{
			if (currentScene)
			{
				currentScene.removeFromParent(true,true);
				currentScene = null;
			}
			
			if (currentMediator)
			{
				facade.removeMediator(currentMediatorName);
			}
			
		}
		/**
		 * 切換到新場景 
		 * @param viewClass
		 * @param mediatorClass
		 * 
		 */		
		protected function showScene(viewClass:Class ,mediatorClass:Class):void
		{
			
			closeScene();
			
			currentMediatorName = mediatorClass.NAME;
			//trace(currentMediatorName);
			currentScene = new viewClass() as Scene;
			currentMediator = new mediatorClass(currentScene) as Mediator;
			
			facade.registerMediator(currentMediator);
			
			lobby.addChild(currentScene);
		}
		/**
		 * 銷毀相關物件 
		 * 
		 */		
		override public function onRemove( ):void 
		{
			
		}
		
		/**
		 * 取得Lobby(document class) 
		 * @return 
		 * 
		 */		
		protected function get lobby():Lobby
		{
			return viewComponent as Lobby;
		}
		
		/**
		 * 取得 ResourceProxy
		 * @see com.cloudnet.common.mvc.model.ResourceProxy
		 * @return 
		 * 
		 */		
		protected function get resourceProxy():ResourceProxy
		{
			var loader:ResourceProxy = ResourceProxy( facade.retrieveProxy( ResourceProxy.NAME ) );
			return loader;
		}
		
		/**
		 * 取得 LoaderInfoProxy
		 * @see com.cloudnet.lobby.model.LoaderInfoProxy
		 * @return 
		 * 
		 */		
		protected function get loaderInfoProxy():LoaderInfoProxy
		{
			var loaderInfo:LoaderInfoProxy = LoaderInfoProxy( facade.retrieveProxy( LoaderInfoProxy.NAME ) );
			return loaderInfo;
		}
		
		/**
		 * 取得 XMLLoaderProxy
		 * @see com.cloudnet.common.mvc.model.XMLLoaderProxy
		 * @return 
		 * 
		 */		
		protected function get xmlProxy():XMLLoaderProxy
		{
			var proxy:XMLLoaderProxy = XMLLoaderProxy(facade.retrieveProxy("DefaultXMLLoaderProxy"));
			return proxy;
		}
		
		/**
		 * 取得 JSONLoaderProxy
		 * @see com.cloudnet.common.mvc.model.JSONLoaderProxy
		 * @return 
		 * 
		 */		
		protected function get josnProxy():JSONLoaderProxy
		{
			var proxy:JSONLoaderProxy = JSONLoaderProxy(facade.retrieveProxy("DefaultJSONLoaderProxy"));
			return proxy;
		}
		
		protected function get languageProxy():LanguageProxy
		{
			var proxy:LanguageProxy = LanguageProxy(facade.retrieveProxy(LanguageProxy.NAME));
			return proxy;
		}
	}
}