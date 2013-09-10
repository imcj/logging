package logging;

interface ILogger implements IBaseLogger
{
    var name(default, null):String;
    var disabled(default, default):Bool;
    var manager(default, default):Manager;
    var parent(default, default):ILogger;
    var propagate(default, default):Bool;
    var handlers(default, null):Array<IHandler>;
    var filterer(default, null):Filterer;

	function log(message:String):Void;
    function getChild(suffix:String):ILogger;
}