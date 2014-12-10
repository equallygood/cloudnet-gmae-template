package com.cloudnet.common.events
{
	import flash.events.Event;
	
	public class SceneEvent extends Event
	{
		public static const SCENE_CHANGE:String = "scene_change";
		
		private var _name:String = "";
		private var _data:Object = {};
		
		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function SceneEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function toString():String {
			return formatToString('SceneEvent', 'type', 'bubbles', 'cancelable', 'name', 'data');
		}
		
		override public function clone():Event {
			var e:SceneEvent = new SceneEvent(this.type, this.bubbles, this.cancelable);
			e.name = this.name;
			e.data = this.data;
			
			return e;
		}

	}
}