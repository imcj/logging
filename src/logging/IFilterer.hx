package logging;

interface IFilterer
{
    function addFilter(filter:IFilter):Void;
    function removeFilter(filter:IFilter):Void;

    function filter(record:LogRecord):Bool;
}