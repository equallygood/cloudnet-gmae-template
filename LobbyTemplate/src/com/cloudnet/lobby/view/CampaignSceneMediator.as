package com.cloudnet.lobby.view
{
	import com.cloudnet.lobby.view.scenes.CampaignScene;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * Campaign場景 Mediator
	 * 用來串接 CampaignScene 與 PureMVC 架構 
	 * @author Administrator
	 * 
	 */
	public class CampaignSceneMediator extends Mediator
	{
		public static const NAME:String = "CampaignSceneMediator";
		
		public function CampaignSceneMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		/**
		 * 取得 CampaignScene
		 * @return 
		 * 
		 */		
		private function get campaignScene():CampaignScene
		{
			return viewComponent as CampaignScene;
		}
	}
}