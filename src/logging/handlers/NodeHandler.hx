package logging.handlers;

import js.Node;

import logging.Handler;
import logging.IHandler;

class NodeHandler extends Handler implements IHandler
{
    var stdout:NodeWriteStream;

    public function new()
    {
        super();
        name = 'StreamHandler';
        stdout = Node.process.stdout;
    }

    override public function flush()
    {
        // stdout.end();
    }

    override public function emit(record:LogRecord):Void
    {
        var message:String;
        try {
            message = format(record);
            stdout.write(message);
            stdout.write("\n");
            // stdout.end();
        } catch (e:Dynamic) {
            trace(e);
            trace(haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
        }
    }
}