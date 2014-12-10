package com.cloudnet.lobby.controller
{
	import com.cloudnet.lobby.LobbyNotification;
	import com.cloudnet.lobby.view.LobbyMediator;
	
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
			facade.registerMediator( new LobbyMediator( note.getBody() ) );
			sendNotification(LobbyNotification.PUREMVC_INIT_COMPLETE);
		}
	}
}