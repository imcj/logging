package logging;

#if haxe3
import haxe.CallStack;
#end
class Formatter implements IFormatter
{
    var fmt:String;
    var datefmt:String;
    var template:interpolation.Template;

    public function new(fmt:String=null, datefmt:String=null)
    {
        if (null == fmt)
            fmt = "$levelname $name $message";
        if (null == datefmt)
            datefmt = "YYYY-MM-DD hh:mm:ss";
        this.fmt = fmt;
        this.datefmt = datefmt;

        template = new interpolation.Template(this.fmt);
    }

    function getFMT():String
    {
        return this.fmt;
    }

    function formatException(stack):String
    {
        return CallStack.toString(stack);
        // return mconsole.StackHelper.toString(stack);
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

        var f:String = template.safe_substitute(record.toStringMap());

        if (record.stack != null) {
            if (record.stackText == null) {
                record.stackText = formatException(record.stack);
            }
            f += record.stackText;
        }

        return f;
    }
}