package logging;

class Logging
{
    static var globalLogger:ILogger = new Logger("");
    public static var manager:Manager;

    static public function log(message:String)
    {
        globalLogger.log(message);
    }

    static public function getLogger(name:String):ILogger
    {
        if (null == Logger.root)
            Logger.root = new RootLogger(0);
        if (null == Logging.manager)
            Logging.manager = new Manager(Logger.root);

        if (null == name || "" == name)
            return manager.root;
        else
            return manager.getLogger(name);
    }
}