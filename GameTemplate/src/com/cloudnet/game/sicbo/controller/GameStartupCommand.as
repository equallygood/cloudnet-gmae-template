package com.cloudnet.game.sicbo.controller
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	/**
	 * MacroCommand在構造方法調用自身的initializeMacroCommand方法。
	 * 實際應用中，你需重寫這個方法，調用addSubCommand添加子Command。 
	 * @author Administrator
	 * 
	 */
	public class GameStartupCommand extends MacroCommand
	{
		
		/**
		 * Override initializeMacroCommand Method
		 * 並加入子命令
		 * 
		 */
		override protected function initializeMacroCommand() :void
		{
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
		}
	}
}