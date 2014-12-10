package com.cloudnet.common.utils
{
	public final class FunMuxUtil
	{
		private const SINGLETON_MSG	: String = "FunMuxUtil Singleton already constructed!";
		
		private static var instance	: FunMuxUtil;
		private var _funs:Vector.<Function> = new Vector.<Function>;
		
		public static function getInstance() : FunMuxUtil 
		{
			if ( instance == null ) instance = new FunMuxUtil( );
			return instance;
		}
		
		public function FunMuxUtil()
		{
			if (instance != null) throw Error(SINGLETON_MSG);
			instance = this;
		}
		
		public function invoke(...args:Array):void
		{
			for each(var fun:Function in _funs)
				fun.apply(null, args);
		}
		
		public function addFun(fun:Function):void
		{
			var len:int = _funs.length;
			var i:int;
			
			while (len--)
				if(_funs[i] === fun)
					return;
			
			_funs.push(fun);
			
			/*for(i=0 ; i<len ; i++)
			{
				if(fun===_funs[i])
				{
					break;
				}
			}
			
			_funs.push(fun);*/
		}
		
		public function removeFun(fun:Function):void
		{
			var len:int = _funs.length;
			var i:int;
			
			while (len--)
				if(_funs[i] === fun)
					_funs.splice(i,1);
					return;
			
			/*for(i=0 ; i<len ; i++)
			{
				if(fun===_funs[i])
				{
					_funs.splice(i,1);
					break;
				}
			}*/
		}
	}
}