package logging;

interface IPlaceHolder extends IBaseLogger
{
    var loggerMap(default, default):StringMap<ILogger>;
    function append(alogger:ILogger):Void;
}