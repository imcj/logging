package logging;

interface IHandler
{
	function addFilter(filter:IFilter):IFilter;
	function removeFilter(filter:IFilter):IFilter;
	function emit(record:LogRecord):Void;
}