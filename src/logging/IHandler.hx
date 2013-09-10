package logging;

interface IHandler
{
    var name(default, default):String;
    var level(default, default):Int;

    // function addFilter(filter:IFilter):IFilter;
    // function removeFilter(filter:IFilter):IFilter;
    function emit(record:LogRecord):Void;
    function handle(record:LogRecord):Bool;
}