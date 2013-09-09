package logging;

class Logger implements ILogger
{
	public var name(default, null):String;
	public var level(default, default):Int;
	public var manager(default, default):Manager;
	public var parent(default, default):ILogger;
	// public var formatter(default, default):Formatter;
	static public var root(default, default):RootLogger;
	// static public var manager:Manager = new Manager(root);

	public function new(name:String, level:Int=0)
	{
		this.name = name;
		this.level = level;
	}

	public function addHandler(handler:IHandler):Void
	{

	}

	public function removeHandler(handler:IHandler):Void
	{
		
	}

	public function log(message:String):Void
	{
		trace(message);
	}

	function _log()
	{

	}

	function handle()
	{
		
	}

	public function getChild(suffix:String):ILogger
	{
		if (root != this)
			suffix = [name, suffix].join(".");
		trace("get child " + suffix);

		return manager.getLogger(suffix);
	}

	public function equal(logger:ILogger):Bool
	{
		return true;
	}

	public function notEqual(logger:ILogger):Bool
	{
		return !equal(logger);
	}
}