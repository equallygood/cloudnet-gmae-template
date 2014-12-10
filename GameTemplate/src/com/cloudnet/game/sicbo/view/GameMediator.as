package com.cloudnet.game.sicbo.view
{
	import com.cloudnet.common.events.CrossDataEvent;
	import com.cloudnet.common.events.SceneEvent;
	import com.cloudnet.common.mvc.model.CommonNotification;
	import com.cloudnet.common.mvc.model.ResourceProxy;
	import com.cloudnet.common.scenes.Scene;
	import com.cloudnet.common.utils.FunMuxUtil;
	import com.cloudnet.common.vo.CrossData;
	import com.cloudnet.game.sicbo.GameNotification;
	import com.cloudnet.game.sicbo.model.LoaderInfoProxy;
	import com.cloudnet.game.sicbo.view.scenes.GameSceneNames;
	import com.cloudnet.game.sicbo.view.scenes.PlayGameScene;
	import com.cloudnet.game.sicbo.view.scenes.SelectTableScene;
	import com.greensock.loading.LoaderMax;
	import com.reintroducing.sound.SoundManager;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * Game Mediator
	 * 用來串接 Game(document class) 與 PureMVC 架構 
	 * @author Administrator
	 * 
	 */
	public class GameMediator extends Mediator
	{
		public static const NAME:String = "GameMediator";
		
		private var _selectTableScene:SelectTableScene;
		private var currentScene:com.cloudnet.common.scenes.Scene;
		private var currentMediator:Mediator;
		
		/**
		 * 建構子
		 * 配置UI事件 
		 * @param viewComponent
		 * 
		 */
		public function GameMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			game.addEventListener(Event.ENTER_FRAME,FunMuxUtil.getInstance().invoke);
			game.addEventListener(SceneEvent.SCENE_CHANGE,changeSceneHandler);
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
				case GameSceneNames.PLAY_GAME:
					
					showScene(PlayGameScene,PlayGameSceneMediator);
					
					break;
				case GameSceneNames.SELECT_TABLE:
					
					showScene(SelectTableScene,SelectTableSceneMediator);
					
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
				GameNotification.PUREMVC_INIT_COMPLETE,
				GameNotification.GAME_RESOURCE_PATH,
				CommonNotification.RESOURCE_LOADER_PROGRESS,
				CommonNotification.RESOURCE_LOADER_COMPLETE,
				CommonNotification.RESOURCE_LOADER_ERROR,
				GameNotification.SELECT_TABLE
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
				case GameNotification.PUREMVC_INIT_COMPLETE:
					
					var crossData:CrossData=new CrossData();
					crossData.status = CrossData.GAME_INIT
					
					var event:CrossDataEvent=new CrossDataEvent(CrossDataEvent.FROM_GAME);
					event.data = crossData;
					loaderInfoProxy.dispatchEvent(event);
					
					break;
				case GameNotification.GAME_RESOURCE_PATH:
					
					resourceProxy.load(data.toString(),"game_resource_doc");
					
					break;
				case CommonNotification.RESOURCE_LOADER_PROGRESS:
					
					var progress:Number=Math.round(Number(data)*100);
					
					break;
				case CommonNotification.RESOURCE_LOADER_COMPLETE:
					
					parseSoundData();
					showScene(SelectTableScene,SelectTableSceneMediator)
					
					break;
				case GameNotification.SELECT_TABLE:
					
					showScene(PlayGameScene,PlayGameSceneMediator);
					
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
			manager.playSound('dokan_no_naka_no_mozart_mp3',1,0,999);
		}
		
		/**
		 * 關閉場景 
		 * 
		 */
		protected function closeScene():void
		{
			if (currentScene)
			{
				currentScene.removeFromParent();
				currentScene = null;
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
			
			currentScene = new viewClass() as Scene;
			currentMediator = new mediatorClass(currentScene) as Mediator;
			
			facade.registerMediator(currentMediator);
			
			game.addChild(currentScene);
		}
		
		/**
		 * 銷毀相關物件 
		 * 
		 */		
		override public function onRemove( ):void 
		{
			
		}
		
		/**
		 * 取得Game(document class) 
		 * @return 
		 * 
		 */
		protected function get game():Game
		{
			return viewComponent as Game;
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
		 * @see com.cloudnet.game.sicbo.model.LoaderInfoProxy
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