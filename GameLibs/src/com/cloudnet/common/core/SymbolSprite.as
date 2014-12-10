package com.cloudnet.common.core
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import org.casalib.core.IDestroyable;
	
	public class SymbolSprite extends Sprite implements IDestroyable
	{
		protected var _symbol:MovieClip;
		protected var _isDestroyed:Boolean;
		
		public function get destroyed():Boolean
		{
			return this._isDestroyed;
		}
		
		public function get symbol():MovieClip
		{
			return this._symbol;
		}
		
		public function SymbolSprite(viewComponent:MovieClip)
		{
			_symbol = viewComponent;
			configUI();
			configEvent();
		}
		
		protected function configUI():void
		{
			addChild(_symbol);
		}
		
		protected function configEvent():void
		{
			
		}
		
		public function destroy():void
		{
			trace("SymbolSprite destroy");
			this._isDestroyed = true;
			
			if (this.parent != null)
				this.parent.removeChild(this);
		}
	}
}