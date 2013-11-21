package logging.handlers;

import sys.io.File;
import sys.io.FileOutput;
import sys.io.FileSeek;

class FileHandler extends Handler implements IHandler
{
    var writer:FileOutput;
    var filename:String;

    public function new(filename:String, delay:Bool=false)
    {
        super();
        name = "FileHandler";
        this.filename = filename;
        if (!delay)
            writer = getWriter(filename);
    }

    function getWriter(filename)
    {
        var w = File.append(filename);

        return w;
    }

    override public function flush()
    {
        writer.flush();
    }

    override public function emit(record:LogRecord):Void
    {
        if (null == writer)
            writer = getWriter(filename);
        var message:String;
        message = format(record);
        writer.writeString(message);
        writer.writeString("\n");
        writer.flush();
    }
}