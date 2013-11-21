package logging;

#if haxe3
import haxe.CallStack;
#end
import haxe.PosInfos;

class Logging
{
    public static var manager:Manager;
    static var root:ILogger;

    // static function __init__()
    // {
    //     var logger = getLogger("");
    //     logger.addHandler(new logging.handlers.StreamHandler());
    // }

    static public function info(message:String, arguments:Dynamic=null,
                                ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        root.info(message, arguments);
    }

    static public function debug(message:String, arguments:Dynamic=null,
                                 ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        root.debug(message, arguments);
    }

    static public function warning(message:String, arguments:Dynamic=null,
                                   ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        root.warning(message, arguments);
    }

    static public function warn(message:String, arguments:Dynamic=null,
                                ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        root.warn(message, arguments);
    }

    static public function error(message:String, arguments:Dynamic=null,
                                 ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        root.error(message, arguments);
    }

    static public function critical(message:String, arguments:Dynamic=null,
                                    ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        root.critical(message, arguments);
    }

    static public function fatal(message:String, arguments:Dynamic=null,
                                 ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        root.fatal(message, arguments);
    }

    static public function log(level:Int, message:String, 
                               ?stack:Array<StackItem>, arguments:Dynamic=null,
                               ?pos:PosInfos):Void
    {
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