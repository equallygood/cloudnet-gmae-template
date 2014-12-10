package com.cloudnet.lobby
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TextEvent;
	/**
	 * Lobby Document Class 
	 * @author Administrator
	 * 
	 */	
	public class Lobby extends Sprite
	{
		public function Lobby()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
		}
		
		protected function onAddedToStage(e:Event):void
		{
			start();
		}
		/**
		 * 啟動 PureMVC 架構 
		 * 
		 */		
		protected function start():void
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			
			LobbyFacade.getInstance().startup(this);
		}
		
	}
}