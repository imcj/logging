package logging;

interface IFilterer
{
    var filters(getFilters, null):Array<IFilter>;
    function addFilter(filter:IFilter):Void;
    function removeFilter(filter:IFilter):Void;

    function filter(record:LogRecord):Bool;
}