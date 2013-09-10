package logging;

class Filter implements IFilter
{
    public var name(default, null):String;
    public var nameSize(default, null):Int;

    public function new(name:String="")
    {
        this.name = name;
        nameSize = name.length;
    }

    public function filter(record:LogRecord):Bool
    {
        if (0 == nameSize)
            return true;
        else if (name == record.name)
            return true;

        var match:String = record.name.substr(0, nameSize);
        if (match == name)
            return true;

        return record.name.substr(nameSize, 1) == ".";
    }
}