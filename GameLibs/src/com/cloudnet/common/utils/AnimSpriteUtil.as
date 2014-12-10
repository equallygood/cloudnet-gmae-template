package com.cloudnet.common.utils
{
	import flash.display.BitmapData;
	
	import fw.anim.AnimSprite;
	import fw.anim.AnimTextureSheet;
	import fw.anim.TileSheetHelper;

	public class AnimSpriteUtil
	{
		public function AnimSpriteUtil()
		{
		}
		
		/*public static function createSpriteSheetAnim(texSheet:AnimTextureSheet,frameRate:Number=30):AnimSprite
		{
			var frames:Array= []; // of int
			
			for (var j:int = 0; j < texSheet.numFrames; j++) {
				frames.push(j);
			}
			var anim:AnimSprite = new AnimSprite();
			
			anim.initialize(texSheet);
			anim.addSequence("all", frames, frameRate);
			
			anim.play("all");
			
			return anim;
		}*/
		
		public static function createSpriteSheetAnim(texture:BitmapData,sheetData:String,frameRate:int=30):AnimSprite
		{
			var helper:TileSheetHelper = new TileSheetHelper();
			
			var texSheet:AnimTextureSheet = helper.prepareAnimTexture(texture, sheetData);
			
			var frames:Array= []; // of int
			
			for (var j:int = 0; j < texSheet.numFrames; j++) {
				frames.push(j);
			}
			var anim:AnimSprite = new AnimSprite();
			
			anim.initialize(texSheet);
			anim.addSequence("all", frames, frameRate);
			
			anim.play("all");
			
			return anim;
		}
	}
}