package logging;

class Filterer
{
    var filters:Array<IFilter>;

    public function new()
    {
        filters = [];
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

    public function remveFilter(filter:IFilter):Void
    {
        filters.remove(filter);
    }

    public function filter(record:LogRecord):Bool
    {
        var enable:Int;
        for (f in filters) {
            if (!f.filter(record)) {
                enable = false;
                break;
            }
        }

        return enable;
    }
}