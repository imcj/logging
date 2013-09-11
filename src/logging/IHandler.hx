package logging;

interface IHandler implements IFilterer
{
    var name(default, default):String;
    var level(default, default):Int;
    var formatter(default, default):IFormatter;

    function format(record:LogRecord):String;
    function flush():Void;
    function emit(record:LogRecord):Void;
    function handle(record:LogRecord):Bool;
}