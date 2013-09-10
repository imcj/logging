package logging;

interface IHandler
{
    var name(default, default):String;
    var level(default, default):Int;
    var formatter(default, default):IFormatter;

    // function addFilter(filter:IFilter):IFilter;
    // function removeFilter(filter:IFilter):IFilter;
    function format(record:LogRecord):String;
    function flush():Void;
    function emit(record:LogRecord):Void;
    function handle(record:LogRecord):Bool;
}