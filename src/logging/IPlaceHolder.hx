package logging;

interface IPlaceHolder implements IBaseLogger
{
    var loggerMap(default, default):StringMap<ILogger>;
    function append(alogger:ILogger):Void;
}