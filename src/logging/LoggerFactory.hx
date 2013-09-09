package logging;

class LoggerFactory implements ILoggerFactory
{
    static public var _shared:ILoggerFactory;

    public function new()
    {

    }

    public function create(name, level:Int=0):ILogger
    {
        return new Logger(name, level);
    }

    static public function shared():ILoggerFactory
    {
        if (null == _shared)
            _shared = new LoggerFactory();

        return _shared;
    }
}