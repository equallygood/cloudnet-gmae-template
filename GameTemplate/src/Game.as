package
{
	import com.cloudnet.game.sicbo.GameFacade;
	
	import flash.display.*;
	import flash.events.Event;
	
	import org.casalib.util.StageReference;
	
	/**
	 * Game Document Class 
	 * @author Administrator
	 * 
	 */
	public class Game extends Sprite
	{
		public function Game()
		{
			if (stage) start();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			start();
		}
		/**
		 * 啟動 PureMVC 架構 
		 * 
		 */
		protected function start():void
		{
			StageReference.setStage(stage);
			
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			
			GameFacade.getInstance().startup(this);
		}
	}
}