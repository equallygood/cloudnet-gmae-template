package com.cloudnet.common.utils
{
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	import fw.anim.AnimSprite;
	
	import org.casalib.display.CasaBitmap;

	public class ResourceUtil
	{
		public function ResourceUtil()
		{
			
		}
		
		public static function getSpriteSheetByName(picName:String,jsonName:String):AnimSprite
		{
			var sheet:Bitmap = ContentDisplay(LoaderMax.getContent(picName)).getChildAt(0) as Bitmap;
			var sheetData:String = LoaderMax.getContent(jsonName);
			
			return AnimSpriteUtil.createSpriteSheetAnim(sheet.bitmapData,sheetData);
		}
		
		public static function getSymbolByName(name:String, className:String):MovieClip
		{
			var symbolLoader:SWFLoader = LoaderMax.getLoader(name) as SWFLoader;
			var classRef:Class = symbolLoader.getClass(className);
			var movieClip:MovieClip = new classRef();
			
			return movieClip;
		}
		
		public static function getBitmapByName(name:String):CasaBitmap
		{
			var content:Bitmap = ContentDisplay(LoaderMax.getContent(name)).getChildAt(0) as Bitmap;
			var bitmap:CasaBitmap = new CasaBitmap(content.bitmapData.clone());
			
			return bitmap;
		}
		
		public static function getBitmapDataByName(name:String):BitmapData
		{
			var content:Bitmap = ContentDisplay(LoaderMax.getContent(name)).getChildAt(0) as Bitmap;
			
			return content.bitmapData.clone();
		}
	}
}