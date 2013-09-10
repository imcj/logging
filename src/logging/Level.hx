package logging;

class Level
{
    static public var CRITICAL:Int = 50;
    static public var FATAL:Int = 50;
    static public var ERROR:Int = 40;
    static public var WARNING:Int = 30;
    static public var WARN:Int = 30;
    static public var INFO:Int = 20;
    static public var DEBUG:Int = 10;
    static public var NOTSET:Int = 0;
    static var levelNames:IntMap<String>;

    static public function getName(level:Int):String
    {
        if (null == levelNames) {
            levelNames = new IntMap<String>();
            levelNames.set(CRITICAL, "CRITICAL");
            levelNames.set(ERROR,    "ERROR");
            levelNames.set(WARNING,  "WARNING");
            levelNames.set(INFO,     "INFO");
            levelNames.set(DEBUG,    "DEBUG");
            levelNames.set(NOTSET,   "NOTSET");
        }

        return levelNames.get(level);
    }
}