package logging;

class Filterer implements IFilterer
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

    public function removeFilter(filter:IFilter):Void
    {
        filters.remove(filter);
    }

    public function filter(record:LogRecord):Bool
    {
        var enable:Bool = true;
        for (f in filters) {
            // disable logging debug trace("Filter <" + f.name + ">.");
            // disable logging debug trace(f.filter(record));
            if (false == f.filter(record)) {
                enable = false;
                break;
            }
        }
        // disable logging debug trace("Filterer filter record " + record.name + " are " + enable);

        return enable;
    }
}