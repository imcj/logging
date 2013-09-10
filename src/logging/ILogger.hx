package logging;

interface ILogger implements IBaseLogger, implements IFilterer
{
    var name(default, null):String;
    var disabled(default, default):Bool;
    var level(default, default):Int;
    var manager(default, default):Manager;
    var parent(default, default):ILogger;
    var propagate(default, default):Bool;
    var handlers(default, null):Array<IHandler>;
    var filterer(default, null):Filterer;

    function addHandler(handler:IHandler):Void;
    function removeHandler(handler:IHandler):Void;
    function debug(message:String, arguments:Dynamic=null):Void;
    function info(message:String, arguments:Dynamic=null):Void;
    function warning(message:String, arguments:Dynamic=null):Void;
    function warn(message:String, arguments:Dynamic=null):Void;
    function error(message:String, arguments:Dynamic=null):Void;
    function log(level:Int, message:String, arguments:Dynamic=null):Void;
    function critical(message:String, arguments:Dynamic=null):Void;
    function fatal(message:String, arguments:Dynamic=null):Void;
    function getChild(suffix:String):ILogger;
}