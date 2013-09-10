package logging;

import massive.munit.Assert;

class LogRecordTest
{
    @Test
    public function testConstructor()
    {
        var record = new LogRecord("name", 10, "pathname", 0, "${name}", 
            {name: "CJ"});
        Assert.areEqual("CJ", record.message);
    }
}