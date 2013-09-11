package logging.handlers.socket;

#if flash
#else
#if neko
import neko.vm.Thread;
#elseif cpp
import cpp.vm.Thread;
#end
import sys.net.Socket;
import sys.net.Host;

class ThreadSocketHandler extends BaseSocketHandler
{
    var thread:Thread;
    var socket:Socket;

    public function new(address:String, level:Int=0)
    {
        super(address, level);
        thread = Thread.create(run);
    }

    function run()
    {
        socket = new Socket();
        socket.connect(new Host(host), port);

        while (true) {
            var message = Thread.readMessage(true);
            socket.write(message);
            socket.write("\n");
        }
    }

    override public function emit(record:LogRecord):Void
    {
        thread.sendMessage(format(record));
    }
}

#end