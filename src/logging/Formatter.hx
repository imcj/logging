package logging;

class Formatter implements IFormatter
{
    var fmt:String;
    var datefmt:String;

    public function new(fmt:String=null, datefmt:String=null)
    {
        if (null == fmt)
            fmt = "$levelname $name $message";
        if (null == datefmt)
            datefmt = "YYYY-MM-DD hh:mm:ss";
        this.fmt = fmt;
        this.datefmt = fmt;
    }

    function formatTime(record:LogRecord)
    {
        var textual = Date.fromTime(record.created).toString();
        return textual + "," + Std.string(record.millisecond);
    }

    function usesTime():Bool
    {
        if (fmt.indexOf("$asctime") > -1)
            return true;
        else
            return false;
    }

    public function format(record:LogRecord):String
    {
        if (usesTime())
            record.asctime = formatTime(record);

        var template = new interpolation.Template(fmt);
        return template.safe_substitute(record.toStringMap());
    }
}