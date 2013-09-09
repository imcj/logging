package logging;

class Filter implements IFilter
{
	public var name(default, null):String;

	public function new(name:String="")
	{
		this.name = name;
	}

	public function record(record:LogRecord):Bool
	{

	}
}