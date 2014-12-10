package com.cloudnet.game.sicbo.controller
{
	//import com.cloudnet.game.model.LoaderInfoProxy;
	
	import com.cloudnet.common.mvc.model.ResourceProxy;
	import com.cloudnet.game.sicbo.model.LoaderInfoProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * SimpleCommand只有一個execute方法，execute方法接受一個Inotification實例做為參數。
	 * 實際應用中，你只需要重寫這個方法  
	 * @author Administrator
	 * 
	 */
	public class ModelPrepCommand extends SimpleCommand
	{
		public function ModelPrepCommand()
		{
			super();
		}
		
		override public function execute( note:INotification ) :void    
		{
			var game:Game = note.getBody() as Game;
			
			facade.registerProxy(new LoaderInfoProxy(game.stage.root.loaderInfo,game.loaderInfo));
			facade.registerProxy(new ResourceProxy());
		}
	}
}