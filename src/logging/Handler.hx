package logging;

class Handler
{
    public var name(default, default):String;

    public function handle(record:LogRecord):Bool
    {
        var available = filter(record);
        if (available)
            emit(record);
        return available;
    }

    function emit(record:LogRecord)
    {
        throw "Not implement."
    }
}