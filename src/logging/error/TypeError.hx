package logging;

class TypeError
{
    public var message(default, null):String;

    public function new(message:String)
    {
        this.message = message;
    }
}