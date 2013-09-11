package logging.handlers.socket;

#if flash
import flash.net.Socket;
import flash.net.XMLSocket;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;

using StringTools;

class FlashSocketHandler extends BaseSocketHandler
{
    var socket:Socket;

    var connected:Bool;
    var cache:Array<String>;

    public function new(address, level:Int=0)
    {
        super(address, level);
        socket = new Socket();
        connected = false;
        cache = [];

        socket.addEventListener(Event.CONNECT, handlerConnect);
        socket.addEventListener(IOErrorEvent.IO_ERROR, handlerIOError);
        socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, 
            handlerSecurityError);

        try {
            socket.connect(host, port);
        } catch(e:Dynamic) {
            // trace("error");
            // trace(e);
        }
    }

    override public function emit(record:LogRecord):Void
    {
        if (!connected) {
            cache.push(format(record));
            return;
        }

        writeLine(format(record));
    }

    function writeLine(message:String)
    {
        var date = Date.now();
        try {
            if (message.startsWith("\n")) {
                message = message.ltrim();
            }
            socket.writeUTF(message);
            socket.writeUTF("\n");
            socket.flush();
        } catch (e:Dynamic) {
            // trace("Write error");
            // trace(e);
        }

    }

    function handlerConnect(e)
    {
        connected = true;
        if (0 < cache.length) {
            for (message in cache) {
                writeLine(message);
            }

            cache = [];
        }
    }

    function handlerIOError(e)
    {
        // trace(e);
    }

    function handlerSecurityError(e)
    {
        // trace(e);
    }
}

#end