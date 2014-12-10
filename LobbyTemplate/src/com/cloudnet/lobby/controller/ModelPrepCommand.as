package com.cloudnet.lobby.controller
{
	import com.cloudnet.common.mvc.model.JSONLoaderProxy;
	import com.cloudnet.common.mvc.model.LanguageProxy;
	import com.cloudnet.common.mvc.model.ResourceProxy;
	import com.cloudnet.common.mvc.model.SocketProxy;
	import com.cloudnet.common.mvc.model.XMLLoaderProxy;
	import com.cloudnet.lobby.Lobby;
	import com.cloudnet.lobby.model.LoaderInfoProxy;
	
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
			var lobby:Lobby = note.getBody() as Lobby;
			
			facade.registerProxy(new LoaderInfoProxy(lobby.stage.root.loaderInfo,lobby.loaderInfo));
			facade.registerProxy(new ResourceProxy());
			facade.registerProxy(new LanguageProxy());
			facade.registerProxy(new XMLLoaderProxy("DefaultXMLLoaderProxy"));
			facade.registerProxy(new JSONLoaderProxy("DefaultJSONLoaderProxy"));
			facade.registerProxy(new SocketProxy());
		}
	}
}