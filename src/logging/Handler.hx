package logging;

class Handler implements IHandler
{
    public var name(default, default):String;
    public var level(default, default):Int;
    public var formatter(default, default):IFormatter;
    public var filterer(default, null):IFilterer;
    public var filters(get_filters, null):Array<IFilter>;

    public function new(level:Int=0)
    {
        this.level = level;
        formatter = new Formatter();
        filterer = new Filterer();
    }

    public function addFilter(filter:IFilter):Void
    {
        filterer.addFilter(filter);
    }

    public function removeFilter(filter:IFilter):Void
    {
        filterer.removeFilter(filter);
    }

    public function filter(record:LogRecord):Bool
    {
        return filterer.filter(record);
    }

    public function flush()
    {

    }

    public function format(record:LogRecord):String
    {
        return formatter.format(record);
    }

    public function handle(record:LogRecord):Bool
    {
        var available = filter(record);
        if (available)
            emit(record);
        return available;
    }

    public function emit(record:LogRecord):Void
    {
        throw "Not implement.";
    }

    function get_filters():Array<IFilter>
    {
        return filterer.filters;
    }
}