package logging;

enum abstract Levels(Int) to Int{
	var TRACE=0;
	var DEBUG=1;
	var INFO=2;
	var WARNING=3;
	var ERROR=4;
}

class Logger {

	var logname:String;

	public function new()
	{
		var dt=DateTools.format(Date.now(),"%Y%m%d%H%M%S");
		this.logname='logs/$dt.log';
	}
	private function log(str:String,level:Levels,pos:haxe.PosInfos)
	{
		if (cast(Logging.level,Int) <= cast(level,Int) ) 
		{
			var dt=Date.now().toString();
			var fn=pos.fileName;
			var ln=pos.lineNumber;
			var slevel=Logging.levelString(level);
			var s='$slevel : $dt : $fn : $ln : $str';
			Sys.println(s);
			var handle=sys.io.File.append(this.logname,false);
			handle.writeString('$s\n');
			handle.flush();
			handle.close();
		}
	}
	public function trace(str:String,?pos:haxe.PosInfos)
	{
		this.log(str,TRACE,pos);
	}
	public function debug(str:String,?pos:haxe.PosInfos)
	{
		this.log(str,DEBUG,pos);
	}
	public function info(str:String,?pos:haxe.PosInfos)
	{
		this.log(str,INFO,pos);
	}
	public function warning(str:String,?pos:haxe.PosInfos)
	{
		this.log(str,WARNING,pos);
	}
	public function error(str:String,?pos:haxe.PosInfos)
	{
		this.log(str,ERROR,pos);
	}
}

class Logging {

	static var logger:Logger;
	public static var level:Levels=TRACE;

	public static function levelString(level:Levels):String
	{
		switch (level)
		{
			case TRACE:return "TRACE";
			case DEBUG:return "DEBUG";
			case INFO:return "INFO";
			case WARNING:return "WARNING";
			case ERROR:return "ERROR";
		}
		return "";
	}
	public static function get():Logger
	{
		if (Logging.logger==null)
		{
			Logging.logger=new Logger();
		}
		return Logging.logger;
	}

	public static function trace(s:String,?pos:haxe.PosInfos)
	{
		Logging.get().trace(s,pos);
	}
	public static function debug(s:String,?pos:haxe.PosInfos)
	{
		Logging.get().debug(s,pos);
	}
	public static function info(s:String,?pos:haxe.PosInfos)
	{
		Logging.get().info(s,pos);
	}
	public static function warning(s:String,?pos:haxe.PosInfos)
	{
		Logging.get().warning(s,pos);
	}
	public static function error(s:String,?pos:haxe.PosInfos)
	{
		Logging.get().error(s,pos);
	}
}

