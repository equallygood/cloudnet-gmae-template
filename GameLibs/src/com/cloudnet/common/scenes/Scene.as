package com.cloudnet.common.scenes
{
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	/**
	 * 
	 * @author Administrator
	 * 
	 */	
	public class Scene extends CasaSprite
	{
		public function Scene()
		{
			super();
			configUI();
			configEvent();
		}
		
		protected function configUI():void
		{
			
		}
		
		protected function configEvent():void
		{
			
		}
		
		protected function frameUpdate(e:Event):void
		{
			
		}
		
		public function removeFromParent(destroyChildren:Boolean = false, recursive:Boolean = false):void
		{
			this.removeAllChildrenAndDestroy(destroyChildren, recursive);
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
	}
}