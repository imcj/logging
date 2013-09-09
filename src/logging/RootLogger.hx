package logging;

class RootLogger extends Logger
{
    public function new(level:Int)
    {
        super("root", level);
    }
}