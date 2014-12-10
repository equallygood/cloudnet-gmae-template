package
{
	import com.cloudnet.common.events.CrossDataEvent;
	import com.cloudnet.common.vo.CrossData;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	
	import fl.lang.Locale;
	
	
	[SWF(width="1024", height="640", frameRate="60", backgroundColor="0xEEEEEE")]
	/**
	 * Lobby與Game載入器 
	 * @author Administrator
	 * 
	 */	
	public class Preloader extends Sprite
	{
		private var _currentLoader:Loader;
		
		private var _resoure:XML;
		
		public function Preloader()
		{
			start();
		}
		
		private function start():void
		{
			var time:Number=new Date().time;
			var timeStamp:String="?time="+time;
			
			var request:URLRequest = new URLRequest(loaderInfo.parameters.resource+timeStamp);
			
			var config:URLLoader = new URLLoader();
			config.load(request);
			config.addEventListener(Event.COMPLETE, dataHandler);
		}
		
		private function dataHandler(e:Event):void
		{
			_resoure = new XML(e.target.data)
			var theme:XML = _resoure.Lobby.Theme[0];
			
			load(theme.@src);
		}
		/**
		 * 載入外部Lobby與Game 
		 * @param url SWF路徑
		 */		
		private function load(url:String):void
		{
			var request:URLRequest = new URLRequest(url);
			
			var appDomain:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			var context:LoaderContext=new LoaderContext(false,appDomain);
			
			_currentLoader = new Loader();
			
			configEvent(_currentLoader.contentLoaderInfo);
			
			var shared:EventDispatcher = _currentLoader.contentLoaderInfo.sharedEvents;
			
			shared.addEventListener(CrossDataEvent.FROM_LOBBY,crossDataHandler);
			shared.addEventListener(CrossDataEvent.FROM_GAME,crossDataHandler);
			
			
			_currentLoader.load(request,context);
		}
		
		private function crossDataHandler(e:CrossDataEvent):void
		{
			trace(e.data.toString());
			switch ( e.type ) 
			{
				case CrossDataEvent.FROM_LOBBY:
					
					fromLobby(e);
					
					break;
				case CrossDataEvent.FROM_GAME:
					
					fromGame(e);
					
					break;
			}
		}
		
		private function fromLobby(event:CrossDataEvent):void
		{
			var shared:EventDispatcher=event.currentTarget as EventDispatcher;
			var status:String = event.data.status;
			
			var replyMessage:CrossDataEvent = new CrossDataEvent(CrossDataEvent.FROM_LOADER);
			
			switch ( status ) 
			{
				case CrossData.LOBBY_INIT:
					
					var theme:XML = _resoure.Lobby.Theme[0];
					
					var crossdata:CrossData = new CrossData();
					crossdata.status = CrossData.LOBBY_RESOURCE;
					crossdata.data = theme.@resource;
					
					replyMessage.data = crossdata;
					
					shared.dispatchEvent(replyMessage);
					
					break;
				case CrossData.LOBBY_READY:
					
					
					
					break;
				case CrossData.GAME_CHANGE:
					
					_currentLoader.unloadAndStop(true);
					destroy(_currentLoader.contentLoaderInfo);
					
					load(getGamePathByID(event.data.data));
					
					break;
			}
		}
		private function getGamePathByID( id:String ):String
		{
			var games:XMLList = _resoure.Games.Game;
			var child:XML;
			
			for each( child in games)
			{
				if(child.@id == id)
				{
					break;
				}
			}
			
			return child.@src;
		}
		/*<data>
			<Lobby>
				<Theme id="lobby_001" name="Hello Lobby" src="Lobby.swf" resource="resource/config/lobby/lobby_theme_001.xml" />
			</Lobby>
			<Games>
				<Game id="table_001" name="poker" src="Game.swf"  resource="resource/config/games/poker.xml" />
				<Game id="table_002" name="sicbo" src="Game.swf" resource="resource/config/games/sicbo.xml" />
			</Games>
		</data>*/
		private function fromGame(event:CrossDataEvent):void
		{
			var shared:EventDispatcher=event.currentTarget as EventDispatcher;
			var status:String = event.data.status;
			
			var replyMessage:CrossDataEvent = new CrossDataEvent(CrossDataEvent.FROM_LOADER);
			
			switch ( status ) 
			{
				case CrossData.GAME_INIT:
					
					var game:XML = _resoure.Games.Game[1];
					
					var crossdata:CrossData = new CrossData();
					crossdata.status = CrossData.GAME_RESOURCE;
					crossdata.data = game.@resource;
					
					replyMessage.data = crossdata;
					
					shared.dispatchEvent(replyMessage);
					
					break;
				case CrossData.BACK_LOBBY:
					
					_currentLoader.unloadAndStop(true);
					destroy(_currentLoader.contentLoaderInfo);
					
					var theme:XML = _resoure.Lobby.Theme[0];
					load(theme.@src);
					
					break;
			}
			
		}
		
		public function destroy(loaderInfo:LoaderInfo):void 
		{
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			loaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loaderInfo.removeEventListener(Event.INIT, initHandler);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loaderInfo.removeEventListener(Event.OPEN, openHandler);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loaderInfo.removeEventListener(Event.UNLOAD, unLoadHandler);
			
			_currentLoader = null;
			
		}
		
		private function configEvent(loaderInfo:LoaderInfo):void
		{
			loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loaderInfo.addEventListener(Event.INIT, initHandler);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loaderInfo.addEventListener(Event.OPEN, openHandler);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loaderInfo.addEventListener(Event.UNLOAD, unLoadHandler);
		}
		
		private function completeHandler(event:Event):void {
			//trace("completeHandler: " + event);
			while(this.numChildren)
			{
				removeChildAt(0);
			}
			
			var loaderInfo:LoaderInfo=event.target as LoaderInfo;
			
			
			addChild(loaderInfo.content);
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			//trace("httpStatusHandler: " + event);
		}
		
		private function initHandler(event:Event):void {
			//trace("initHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			//trace("ioErrorHandler: " + event);
		}
		
		private function openHandler(event:Event):void {
			//trace("openHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			//trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		
		private function unLoadHandler(event:Event):void {
			//trace("unLoadHandler: " + event);
		}
		
	}
}