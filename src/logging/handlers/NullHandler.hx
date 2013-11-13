package logging.handlers;

import haxe.io.Output;

import logging.Handler;
import logging.IHandler;

class NullHandler extends Handler implements IHandler
{
    public function new()
    {
        super();
    }

    override public function emit(record:LogRecord):Void
    {
    }
}