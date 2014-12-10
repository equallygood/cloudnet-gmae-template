package com.cloudnet.lobby.view.scenes
{
	import com.cloudnet.common.events.SceneEvent;
	import com.cloudnet.common.scenes.Scene;
	import com.cloudnet.common.vo.SocketData;
	
	import fl.controls.Button;
	import fl.controls.Label;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.Socket;
	/**
	 * Socket Demo 場景 
	 * @author Administrator
	 * 
	 */	
	public class SocketDemoScene extends Scene
	{
		private var _ipInput:TextInput;
		private var _portInput:TextInput;
		private var _priorityInput:TextInput;
		private var _typeInput:TextInput;
		private var _messageNumInput:TextInput;
		private var _contentInput:TextInput;
		private var _connectButton:Button;
		private var _closeButton:Button;
		private var _sendButton:Button;
		
		private var _textArea:TextArea;
		
		private var _goLobby:Button;
		
		private var _contentClip:Sprite;
		
		private var _data:SocketData = new SocketData();
		private var _ip:String = "127.0.0.1";
		private var _port:int = 8087;
		
		/**
		 * 取得Demo用數據 
		 * @return 
		 * 
		 */		
		public function get data():SocketData
		{
			return _data;
		}
		/**
		 * 取得ip 
		 * @return 
		 * 
		 */		
		public function get ip():String
		{
			return _ip;
		}
		/**
		 * 取得port 
		 * @return 
		 * 
		 */		
		public function get port():int
		{
			return _port;
		}
		/**
		 * 取得連接Button 
		 * @return 
		 * 
		 */		
		public function get connectBtn():Button
		{
			return _connectButton;
		}
		/**
		 * 取得關閉連接Button 
		 * @return 
		 * 
		 */		
		public function get closeBtn():Button
		{
			return _closeButton;
		}
		/**
		 * 取得傳送Button 
		 * @return 
		 * 
		 */		
		public function get sendBtn():Button
		{
			return _sendButton;
		}
		
		public function SocketDemoScene()
		{
			super();
		}
		/**
		 * 配置交互UI與版面 
		 * 
		 */		
		override protected function configUI():void
		{
			_goLobby = new Button();
			_goLobby.label = "Lobby";
			addChild(_goLobby);
			
			_contentClip=new Sprite();
			_contentClip.x=200;_contentClip.y=120;
			addChild(_contentClip);
			var label:Label;
			
			label = new Label();
			label.text = "IP";
			label.width = 150;
			_contentClip.addChild(label);
			
			label = new Label();
			label.text = "Port";
			label.width = 150;
			label.y = 30;
			_contentClip.addChild(label);
			
			label = new Label();
			label.text = "Priority(int)";
			label.width = 150;
			label.y = 60
			_contentClip.addChild(label);
			
			label = new Label();
			label.text = "Type(int)";
			label.width = 150;
			label.y = 90;
			_contentClip.addChild(label);
			
			label = new Label();
			label.text = "MessageNum(int)";
			label.width = 150;
			label.y = 120;
			_contentClip.addChild(label);
			
			label = new Label();
			label.text = "Content(String A-Z a-z 0-9)";
			label.width = 150;
			label.y = 150;
			_contentClip.addChild(label);
			
			_ipInput = new TextInput();
			_ipInput.enabled = false;
			_ipInput.text = "127.0.0.1";
			_ipInput.width = 200;
			_ipInput.maxChars = 15;
			_ipInput.restrict = "localhost . 0-9";
			_ipInput.x = 150;
			_contentClip.addChild(_ipInput);
			
			_portInput = new TextInput();
			_portInput.enabled = false;
			_portInput.text = "8087";
			_portInput.width = 200;
			_portInput.maxChars = 6;
			_portInput.restrict = "0-9";
			_portInput.move(150,30);
			_contentClip.addChild(_portInput);
			
			_priorityInput = new TextInput();
			_priorityInput.text = "10001";
			_priorityInput.width = 200;
			_priorityInput.maxChars = 5;
			_priorityInput.restrict = "0-9";
			_priorityInput.move(150,60);
			_contentClip.addChild(_priorityInput);
			
			_typeInput = new TextInput();
			_typeInput.text = "20001";
			_typeInput.width = 200;
			_typeInput.maxChars = 5;
			_typeInput.restrict = "0-9";
			_typeInput.move(150,90);
			_contentClip.addChild(_typeInput);
			
			_messageNumInput = new TextInput();
			_messageNumInput.text = "30001";
			_messageNumInput.width = 200;
			_messageNumInput.maxChars = 5;
			_messageNumInput.restrict = "0-9";
			_messageNumInput.move(150,120);
			_contentClip.addChild(_messageNumInput);
			
			_contentInput = new TextInput();
			_contentInput.text = "Hello CloudNet";
			_contentInput.width = 200;
			_contentInput.maxChars = 50;
			//_contentInput.restrict = "A-Z a-z 0-9";
			_contentInput.move(150,150);
			_contentClip.addChild(_contentInput);
			
			_connectButton = new Button();
			_connectButton.label = "Connect";
			_connectButton.x = 400;
			_contentClip.addChild(_connectButton);
			
			_closeButton = new Button();
			_closeButton.label = "close";
			_closeButton.x = 500;
			_contentClip.addChild(_closeButton);
			
			_sendButton = new Button();
			_sendButton.label = "Send";
			_sendButton.move(400,150);
			_contentClip.addChild(_sendButton);
			
			_textArea = new TextArea();
			_textArea.editable = false;
			_textArea.setSize(400,300);
			_textArea.y = 200;
			_contentClip.addChild(_textArea);
			
		}
		/**
		 * 配置交互事件 
		 * 
		 */		
		override protected function configEvent():void
		{
			_connectButton.addEventListener(MouseEvent.CLICK,clickHandler);
			_closeButton.addEventListener(MouseEvent.CLICK,clickHandler);
			_sendButton.addEventListener(MouseEvent.CLICK,clickHandler);
			
			_goLobby.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		/**
		 * 處理交互事件 
		 * @param e
		 * 
		 */		
		protected function clickHandler(e:MouseEvent):void
		{
			if(e.currentTarget == _connectButton)
			{
				this.dispatchEvent(new Event("connect_to_server"));
			}
			else if(e.currentTarget == _closeButton)
			{
				this.dispatchEvent(new Event("close_socket"));
			}
			else if(e.currentTarget == _sendButton)
			{
				_data.priority = int(_priorityInput.text);
				_data.type = int(_typeInput.text);
				_data.messageNum = int(_messageNumInput.text);
				_data.content = _contentInput.text;
				
				this.dispatchEvent(new Event("send_data"));
			}
			else
			{
				var event:SceneEvent=new SceneEvent(SceneEvent.SCENE_CHANGE,true);
				event.name = LobbySceneNames.LOBBY;
				this.dispatchEvent(event);
			}
		}
		/**
		 * 接收Socket messages並更新Text Area 
		 * @param messages
		 * 
		 */		
		public function receiveMessages(messages:String):void
		{
			messages += "\n";
			_textArea.appendText(messages);
			
			_textArea.verticalScrollPosition = _textArea.maxVerticalScrollPosition;
		}
		/**
		 * 銷毀相關物件與事件 
		 * 
		 */		
		override public function destroy():void 
		{
			super.destroy();
			
			_connectButton.removeEventListener(MouseEvent.CLICK,clickHandler);
			_closeButton.removeEventListener(MouseEvent.CLICK,clickHandler);
			_sendButton.removeEventListener(MouseEvent.CLICK,clickHandler);
		}
	}
}