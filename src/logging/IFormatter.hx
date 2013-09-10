package logging;

interface IFormatter
{
    function format(record:LogRecord):String;
}