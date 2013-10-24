package logging;

import haxe.PosInfos;

#if haxe3
import haxe.CallStack;
#end

using logging.ArrayHelper;

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
    public var filters(get_filters, null):Array<IFilter>;
    static public var root(default, default):RootLogger;

    public function new(name:String, level:Int=0)
    {
        this.name = name;
        this.level = level;
        this.disabled = false;
        filterer = new Filterer();
        handlers = [];
        filterer = new Filterer();
        propagate = true;
        this.level = level;
    }

    public function addFilter(filter:IFilter):Void
    {
        filterer.addFilter(filter);
    }

    public function removeFilter(filter:IFilter):Void
    {
        filterer.removeFilter(filter);
    }

    public function filter(record:LogRecord):Bool
    {
        return filterer.filter(record);
    }

    public function addHandler(handler:IHandler):Void
    {
        if (!this.handlers.has(handler))
            this.handlers.push(handler);
    }

    public function removeHandler(handler:IHandler):Void
    {
        handlers.remove(handler);   
    }

    function getEffectiveLevel()
    {
        var logger:ILogger = this;
        while (true) {
            #if cpp
            #elseif !flash
            if (null != logger.level)
                return logger.level;
            #end
            if (null == logger)
                break;
                
            if (0 != logger.level)                
                return logger.level;

            logger = logger.parent;
        }

        return Level.NOTSET;
    }

    public function isEnableFor(level:Int):Bool
    {
        if (manager.disable >= level)
            return false;

        return level >= getEffectiveLevel();
    }

    public function debug(message:String, arguments:Dynamic=null,
                          ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        if (isEnableFor(Level.DEBUG))
            _log(Level.DEBUG, message, arguments, stack);
    }

    public function info(message:String, arguments:Dynamic=null,
                         ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        if (isEnableFor(Level.INFO))
            _log(Level.INFO, message, arguments, stack);
    }

    public function warning(message:String, arguments:Dynamic=null,
                            ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        if (isEnableFor(Level.WARNING))
            _log(Level.WARNING, message, arguments, stack);
    }

    public function warn(message:String, arguments:Dynamic=null,
                         ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        if (isEnableFor(Level.WARNING))
            _log(Level.WARNING, message, arguments, stack);
    }

    public function error(message:String, arguments:Dynamic=null,
                          ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        if (isEnableFor(Level.ERROR))
            _log(Level.ERROR, message, arguments, stack);
    }

    public function critical(message:String, arguments:Dynamic=null,
                             ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        if (isEnableFor(Level.CRITICAL))
            _log(Level.CRITICAL, message, arguments, stack);
    }

    public function fatal(message:String, arguments:Dynamic=null,
                          ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        if (isEnableFor(Level.CRITICAL))
            _log(Level.CRITICAL, message, arguments, stack);
    }

    public function log(level:Int, message:String, arguments:Dynamic=null,
                        ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        if (isEnableFor(level))
            _log(level, message, arguments, stack);
    }

    function _log(level:Int, message:String, arguments:Dynamic,
                  ?stack:Array<StackItem>, ?pos:PosInfos)
    {
        var record:LogRecord = new LogRecord(name, level, pos.fileName, 
            pos.lineNumber, message, arguments, stack);
        handle(record);
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
            for (handler in _logger.handlers) {
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
            manager.emittedNoHandlerWarning = true;
        }
    }

    public function getChild(suffix:String):ILogger
    {
        if (root != this)
            suffix = [name, suffix].join(".");

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

    function get_filters():Array<IFilter>
    {
        return this.filterer.filters;
    }
}