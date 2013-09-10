package logging;

class Manager
{
    public var root:RootLogger;
    public var disable:Int;
    public var emittedNoHandlerWarning:Bool;
    public var loggerMap(default, null):StringMap<IBaseLogger>;
    public var loggerFactory(default, default):ILoggerFactory;

    public function new(root)
    {
        this.root = root;
        disable = 0;
        loggerMap = new StringMap<IBaseLogger>();
        loggerFactory = LoggerFactory.shared();
        emittedNoHandlerWarning = false;
    }

    public function getLogger(name:String):ILogger
    {
        var logger:ILogger = null;
        var baseLogger:IBaseLogger;
        var placeholder:IPlaceHolder;

        if (loggerMap.exists(name)) {
            baseLogger = loggerMap.get(name);
            if (Std.is(logger, IPlaceHolder)) {
                placeholder = cast baseLogger;

                logger = loggerFactory.create(name);
                logger.manager = this;
                loggerMap.set(name, logger);
                _fixupChildren(placeholder, logger);
                _fixupParents(logger);
            }
            logger = cast(baseLogger);
        } else {
            logger = loggerFactory.create(name);
            logger.manager = this;
            loggerMap.set(name, logger);
            _fixupParents(logger);
        }

        return logger;
    }

    function _fixupParents(alogger:ILogger)
    {
        var name:String = alogger.name;
        // disable logging debug trace("Fixup " + name);
        var parent_name:String;
        var i:Int = name.lastIndexOf(".");
        var rv:ILogger = null;
        var obj:IBaseLogger;
        while (i > 0 && null == rv ) {
            parent_name = name.substring(0, i);
            // disable logging debug trace(Std.format("parent name $parent_name"));

            if (!loggerMap.exists(parent_name))
                loggerMap.set(parent_name, new PlaceHolder(alogger));
            else {
                obj = loggerMap.get(parent_name);
                // disable logging debug trace(obj);
                if (Std.is(obj, ILogger))
                    rv = cast obj;
                else if (Std.is(obj, IPlaceHolder))
                    (cast(obj, IPlaceHolder)).append(alogger);
            }

            i = parent_name.lastIndexOf(".");
        }

        if (null == rv)
            rv = root;

        alogger.parent = rv;
    }

    function _fixupChildren(placeholder:IPlaceHolder, alogger:ILogger)
    {
        var name = alogger.name;
        var name_size = name.length;
        // var logger:ILogger; 

        for (logger in placeholder.loggerMap.iterator()) {
            if (logger.parent.name.substring(0, name_size) != name) {
                alogger.parent = logger.parent;
                logger.parent = alogger;
            }
        }
    }
}