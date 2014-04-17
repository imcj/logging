package logging.handlers;

import haxe.io.Output;

import logging.Handler;
import logging.IHandler;

class StreamHandler extends Handler implements IHandler
{
    var stream:Output;

    public function new(stream:Output=null)
    {
        super();
        name = 'StreamHandler';
        #if (php || neko || cpp)
        if (null == stream)
            stream = Sys.stderr();
        #end
        this.stream = stream;
    }

    override public function flush()
    {
        stream.flush();
    }

    override public function emit(record:LogRecord):Void
    {
        var message:String;
        try {
            message = format(record);
            #if (flash || as3 || js)
            trace(message);
            #else
            stream.writeString(message);
            stream.writeString("\n");
            stream.flush();
            #end
        } catch (e:Dynamic) {
            trace("Stream is null " + (null == stream));
            trace(e);
            trace(haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
        }
    }
}
