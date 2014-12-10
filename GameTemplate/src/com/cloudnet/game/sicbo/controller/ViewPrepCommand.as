package com.cloudnet.game.sicbo.controller
{
	import com.cloudnet.game.sicbo.GameNotification;
	import com.cloudnet.game.sicbo.view.GameMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * SimpleCommand只有一個execute方法，execute方法接受一個Inotification實例做為參數。
	 * 實際應用中，你只需要重寫這個方法 
	 * @author Administrator
	 * 
	 */
	public class ViewPrepCommand extends SimpleCommand
	{
		override public function execute( note:INotification ) :void    
		{
			facade.registerMediator( new GameMediator( note.getBody() ) );
			sendNotification(GameNotification.PUREMVC_INIT_COMPLETE);
		}
	}
}