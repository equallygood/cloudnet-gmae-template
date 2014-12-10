package com.cloudnet.common.utils
{
	import flash.utils.getQualifiedClassName;
	
	public class StringUtil
	{
		public function StringUtil()
		{
		}
		
		public static function formatToString(object:Object, ...args):String
		{
			var string:String = "["+getClassName(object)+" ";
			var property:String;
			
			if (args.length == 1 && args[0] is Array)
			{
				args = args[0];
			}
			
			for each (property in args)
			{
				string = string.concat(property+"=\""+object[property]+"\", ");
			}
			string = string.substr(0, string.length - 2);
			return string.concat("]");
		}
		
		public static function getClassName(object:Object):String
		{
			var name:String = getQualifiedClassName(object);
			var index:int = name.lastIndexOf("::");
			if (index == -1) // Top-level class
			{
				index = name.lastIndexOf(".")+1;
			}
			else
			{
				index+=2;
			}
			return name.substring(index);
		}
	}
}