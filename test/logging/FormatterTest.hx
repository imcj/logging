package logging;

class FormatterTest
{
    @Test
    public function testFormat()
    {
        var record = new LogRecord("name2", 10, "pathname", 0, "${name}", 
            {name: "CJ"});
        var formatter = new Formatter();
    }
}