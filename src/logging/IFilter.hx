package logging;

interface IFilter
{
	function filter(record:LogRecord):Bool;
}