package logging;

class Filterer implements IFilterer
{
    public var filters(getFilters, null):Array<IFilter>;

    public function new()
    {
        filters = [];
    }

    function getFilters():Array<IFilter>
    {
        return this.filters;
    }

    public function addFilter(filter:IFilter):Void
    {
        var found:Bool = false;
        for (f in filters)
            if (f == filter)
                found = true;

        if (!found)
            filters.push(filter);
    }

    public function removeFilter(filter:IFilter):Void
    {
        filters.remove(filter);
    }

    public function filter(record:LogRecord):Bool
    {
        var enable:Bool = true;
        for (f in filters) {
            if (false == f.filter(record)) {
                enable = false;
                break;
            }
        }

        return enable;
    }
}