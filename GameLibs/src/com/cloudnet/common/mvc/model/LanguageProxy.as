package com.cloudnet.common.mvc.model
{
	import fl.lang.Locale;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LanguageProxy extends Proxy
	{
		public static const NAME:String = "LanguageProxy";
		
		private var _langData:XML;
		private var _currentLang:String;
		
		public function LanguageProxy()
		{
			super(NAME);
			Locale.setLoadCallback(localeLoadedHandler);
		}
		
		public function initializeLang(data:XML):void
		{
			_langData = data;
			
			var child:XML;
			
			for each (child in data.Lang)
			{
				trace(child.@locale, child.@url);
				Locale.addXMLPath(child.@locale, child.@url);
			}
			
			_currentLang = LanguageCode.ENGLISH;
			Locale.loadLanguageXML(LanguageCode.ENGLISH);
			
			/*
			<Languages prependURLs="http://localhost:8081/cloudnet/">
				<Lang locale="zh-TW" url="lang/lobby/lobby_zh_TW.xml" />
				<Lang locale="zh-CN" url="lang/lobby/lobby_zh_CN.xml" />
				<Lang locale="en" url="lang/lobby/lobby_en.xml" />
			</Languages>
			*/
		}
		
		private function localeLoadedHandler(success:Boolean):void
		{
			// TODO Auto Generated method stub
			if(success)
			{
				this.sendNotification(CommonNotification.LANGUAGE_COMPLETE,_currentLang);
			}
			
		}
		
		public function loadLanguageXML(langCode:String):void
		{
			_currentLang = langCode;
			Locale.loadLanguageXML(langCode);
		}
		
		public function getStringByID(id:String):String
		{
			return Locale.loadString(id);
		}
	}
}