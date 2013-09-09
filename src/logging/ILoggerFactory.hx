package logging;

interface ILoggerFactory
{
    function create(name:String, level:Int=0):ILogger;
}