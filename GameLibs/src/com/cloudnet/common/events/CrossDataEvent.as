package com.cloudnet.common.events
{
	import com.cloudnet.common.vo.CrossData;
	
	import flash.events.Event;

	/**
	 * 跨SWF傳送數據
	 * 安全性考量只傳送簡單數據 
	 * @example
			<code>
				
			</code>
	 * @author Administrator
	 * 
	 */	
	public class CrossDataEvent extends Event
	{
		public static const FROM_LOBBY:String 	= "from_lobby";
		public static const FROM_GAME:String 	= "from_game";
		public static const FROM_LOADER:String 	= "from_loader";
		
		private var _data:CrossData;
		
		public function get data():CrossData
		{
			return _data;
		}
		
		public function set data(value:CrossData):void
		{
			_data = value;
		}
		
		public function CrossDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString('CrossDataEvent', 'type', 'bubbles', 'cancelable', 'data');
		}
		
		override public function clone():Event {
			var e:CrossDataEvent = new CrossDataEvent(this.type, this.bubbles, this.cancelable);
			e.data = this.data;
			
			return e;
		}
	}
}