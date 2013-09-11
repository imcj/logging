package logging.handlers.socket;

import logging.Handler;

class BaseSocketHandler extends Handler, implements IHandler
{
    var address:String;
    var host:String;
    var port:Int;

    public function new(address:String, level:Int=0)
    {
        super(level);

        this.address = address;
        var addr = address.split(":");
        host = addr[0];
        port = Std.parseInt(addr[1]);
    }
}