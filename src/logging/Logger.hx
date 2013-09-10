package logging;

class Logger implements ILogger
{
	public var name(default, null):String;
	public var disabled(default, default):Bool;
	public var level(default, default):Int;
	public var manager(default, default):Manager;
	public var parent(default, default):ILogger;
	public var propagate(default, default):Bool;
	public var handlers(default, null):Array<IHandler>;
	public var filterer(default, null):Filterer;
	// public var formatter(default, default):Formatter;
	static public var root(default, default):RootLogger;
	// static public var manager:Manager = new Manager(root);

	public function new(name:String, level:Int=0)
	{
		this.name = name;
		this.level = level;
		this.disabled = false;
		filterer = new Filterer();
		handlers = [];
		filterer = new Filterer();
		propagate = true;
	}

	public function addHandler(handler:IHandler):Void
	{

	}

	public function removeHandler(handler:IHandler):Void
	{
		
	}

	public function log(message:String):Void
	{
	}

	function _log(level:Int, message:String, arguments:Dynamic)
	{

	}

	function handle(record:LogRecord)
	{
		if ((! this.disabled) && filterer.filter(record))
			callHandlers(record);
	}

	function callHandlers(record:LogRecord)
	{
		var _logger:ILogger = this;
		var found:Int = 0;
		while (null != _logger) {
			for (handler in handlers) {
				found += 1;
				if (record.levelno >= handler.level)
					handler.handle(record);
			}

			if (!_logger.propagate)
				_logger = null;
			else
				_logger = _logger.parent;
		}

		if (0 == found && !manager.emittedNoHandlerWarning) {
			// error
			manager.emittedNoHandlerWarning = true;
		}
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