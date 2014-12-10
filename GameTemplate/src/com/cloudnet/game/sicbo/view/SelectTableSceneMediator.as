package com.cloudnet.game.sicbo.view
{
	import com.cloudnet.common.events.SceneEvent;
	import com.cloudnet.game.sicbo.GameNotification;
	import com.cloudnet.game.sicbo.events.SelectTableEvent;
	import com.cloudnet.game.sicbo.view.scenes.SelectTableScene;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * Select Table場景 Mediator
	 * 用來串接SelectTable Scene 與 PureMVC 架構 
	 * @author Administrator
	 * 
	 */
	public class SelectTableSceneMediator extends Mediator
	{
		public static const NAME:String = "SelectTableSceneMediator";
		
		public function SelectTableSceneMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		/**
		 * 銷毀相關物件 
		 * 
		 */		
		override public function onRemove( ):void 
		{
			
		}
		
		/**
		 * 取得場景參照 
		 * @return 
		 * 
		 */
		protected function get selectTableScene():SelectTableScene
		{
			return viewComponent as SelectTableScene;
		}
	}
}