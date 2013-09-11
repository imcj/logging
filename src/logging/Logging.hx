package logging;

class Logging
{
    public static var manager:Manager;
    static var root:ILogger;

    static function initializeRootLogger()
    {
        var logger:ILogger;
        var handler:IHandler;
        logger = getLogger("");
        if (null == root)
            root = logger;
        if (0 == logger.handlers.length) {
            handler = new logging.handlers.StreamHandler();
            logger = Logging.getLogger("");
            logger.addHandler(handler);
        }
    }

    static public function info(message:String, arguments:Dynamic=null):Void
    {
        initializeRootLogger();
        root.info(message, arguments);
    }

    static public function debug(message:String, arguments:Dynamic=null):Void
    {
        initializeRootLogger();
        root.debug(message, arguments);
    }

    static public function warning(message:String, arguments:Dynamic=null):Void
    {
        initializeRootLogger();
        root.warning(message, arguments);
    }

    static public function warn(message:String, arguments:Dynamic=null):Void
    {
        initializeRootLogger();
        root.warn(message, arguments);
    }

    static public function error(message:String, arguments:Dynamic=null):Void
    {
        initializeRootLogger();
        root.error(message, arguments);
    }

    static public function critical(message:String, arguments:Dynamic=null):Void
    {
        initializeRootLogger();
        root.critical(message, arguments);
    }

    static public function fatal(message:String, arguments:Dynamic=null):Void
    {
        initializeRootLogger();
        root.fatal(message, arguments);
    }

    static public function log(level:Int, message:String, arguments:Dynamic=null):Void
    {
        initializeRootLogger();
        root.log(level, message, arguments);
    }

    static public function getLogger(name:String):ILogger
    {
        if (null == Logger.root)
            Logger.root = new RootLogger(0);
        if (null == Logging.manager) {
            Logging.manager = new Manager(Logger.root);
            Logger.root.manager = Logging.manager;
        }

        var logger:ILogger;
        if (null == name || "" == name)
            logger = manager.root;
        else
            logger = manager.getLogger(name);

        return logger;
    }
}