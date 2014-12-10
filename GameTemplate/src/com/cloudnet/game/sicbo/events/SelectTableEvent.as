package com.cloudnet.game.sicbo.events
{
	import flash.events.Event;
	
	/**
	 * 自訂義事件範例 
	 * @author Administrator
	 * 
	 */	
	public class SelectTableEvent extends Event
	{
		public static const SELECT_TABLE:String="select_table";
		
		private var _data:String = "";
		
		public function get data():String
		{
			return _data;
		}
		
		public function set data(value:String):void
		{
			_data = value;
		}
		
		public function SelectTableEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString('SelectTableEvent', 'type', 'bubbles', 'cancelable', 'data');
		}
		
		override public function clone():Event {
			var e:SelectTableEvent = new SelectTableEvent(this.type, this.bubbles, this.cancelable);
			e.data        = this.data;
			
			return e;
		}

	}
}