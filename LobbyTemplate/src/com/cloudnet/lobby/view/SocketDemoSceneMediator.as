package com.cloudnet.lobby.view
{
	import com.cloudnet.common.mvc.model.CommonNotification;
	import com.cloudnet.common.mvc.model.SocketProxy;
	import com.cloudnet.lobby.view.scenes.SocketDemoScene;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * Socket Demo場景 Mediator
	 * 用來串接 Socket Demo Scene 與 PureMVC 架構 
	 * @author Administrator
	 * 
	 */	
	public class SocketDemoSceneMediator extends Mediator
	{
		public static const NAME:String = "SocketDemoSceneMediator";
		
		private var _connection:Boolean = false;
		/**
		 * 建構子
		 * 配置事件與UI狀態 
		 * @param viewComponent SocketDemoScene
		 * 
		 */		
		public function SocketDemoSceneMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			socketDemoScene.addEventListener("connect_to_server",socketDemoSceneHandler,false,0,true);
			socketDemoScene.addEventListener("close_socket",socketDemoSceneHandler,false,0,true);
			socketDemoScene.addEventListener("send_data",socketDemoSceneHandler,false,0,true);
			
			socketDemoScene.closeBtn.enabled = false;
			socketDemoScene.sendBtn.enabled = false;
		}
		
		/**
		 * 處理場景交互 
		 * @param e
		 * 
		 */		
		protected function socketDemoSceneHandler(e:Event):void
		{
			var type:String = e.type;
			
			switch ( type ) 
			{
				case 'connect_to_server':
					
					socketDemoScene.connectBtn.enabled = false;
					socketProxy.connect(socketDemoScene.ip, socketDemoScene.port);
					
					break;
				case 'close_socket':
					
					socketDemoScene.closeBtn.enabled = false;
					socketProxy.close();
					
					break;
				case 'send_data':
					
					var message:String = JSON.stringify(socketDemoScene.data);
					socketProxy.sendString(message);
					
					break;
			}
		}
		/**
		 * 定義感興趣的通知清單 
		 * @return 
		 * 
		 */
		override public function listNotificationInterests():Array 
		{
			return [
				CommonNotification.CONNECTION_SOCKET,
				CommonNotification.RECEIVE_SOCKET_MESSAGE,
				CommonNotification.CONNECTION_CLOSED_BY_CLIENT,
				CommonNotification.CONNECTION_CLOSED_BY_SERVER
			];
		}
		/**
		 * 處理感興趣的通知 
		 * @param note
		 * 
		 */
		override public function handleNotification( note:INotification ):void 
		{
			var notificationName:String = note.getName();
			var data:Object = note.getBody();
			
			switch ( notificationName ) 
			{
				case CommonNotification.CONNECTION_SOCKET:
					
					_connection = true;
					
					socketDemoScene.sendBtn.enabled = true;
					socketDemoScene.connectBtn.enabled = false;
					socketDemoScene.closeBtn.enabled = true;
					socketDemoScene.receiveMessages(String(data));
					
					break;
				case CommonNotification.RECEIVE_SOCKET_MESSAGE:
					
					socketDemoScene.receiveMessages(String(data));
					
					break;
				case CommonNotification.CONNECTION_CLOSED_BY_CLIENT:
					
					_connection = false;
					
					socketDemoScene.sendBtn.enabled = false;
					socketDemoScene.connectBtn.enabled = true;
					socketDemoScene.closeBtn.enabled = false;
					socketDemoScene.receiveMessages(String(data));
					
					break;
				case CommonNotification.CONNECTION_CLOSED_BY_SERVER:
					
					_connection = false;
					
					socketDemoScene.sendBtn.enabled = false;
					socketDemoScene.connectBtn.enabled = true;
					socketDemoScene.closeBtn.enabled = false;
					socketDemoScene.receiveMessages(String(data));
					
					break;
			}
		}
		/**
		 * 銷毀相關物件 
		 * 
		 */		
		override public function onRemove( ):void 
		{
			trace(this,"onRemove");	
			if(_connection)
			{
				socketProxy.close();
			}
		}
		/**
		 * 取得SocketProxy
		 * @see com.cloudnet.common.mvc.model.SocketProxy
		 * @return 
		 * 
		 */		
		protected function get socketProxy():SocketProxy
		{
			var proxy:SocketProxy = SocketProxy(facade.retrieveProxy("SocketProxy"));
			
			return proxy;
		}
		
		/**
		 * 取得場景參照 
		 * @return 
		 * 
		 */		
		protected function get socketDemoScene():SocketDemoScene
		{
			return this.viewComponent as SocketDemoScene;
		}
	}
}