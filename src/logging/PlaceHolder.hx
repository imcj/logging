package logging;

class PlaceHolder implements IPlaceHolder
{
    public var loggerMap(default, default):StringMap<ILogger>;
    
    public function new(alogger:ILogger)
    {
        loggerMap = new StringMap<ILogger>();
        loggerMap.set(alogger.name, alogger);
    }

    public function append(alogger:ILogger)
    {
        loggerMap.set(alogger.name, alogger);
    }
}