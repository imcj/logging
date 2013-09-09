package logging;

interface ILogger implements IBaseLogger
{
    var name(default, null):String;
    var manager(default, default):Manager;
    var parent(default, default):ILogger;

	function log(message:String):Void;
    function getChild(suffix:String):ILogger;
}