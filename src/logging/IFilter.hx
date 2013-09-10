package logging;

interface IFilter
{
    var name(default, null):String;

    function filter(record:LogRecord):Bool;
}