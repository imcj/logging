package logging;

import massive.munit.Assert;

class LoggingTest
{
    var stream:MockStream;

    @Before
    public function setUp()
    {
        var root = Logging.getLogger("");
        while (root.handlers.pop() != null) {};
        stream = new MockStream();
        var handler = new logging.handlers.StreamHandler(stream);
        root.addHandler(handler);
    }

    @Test
    @TestDebug
    public function testLog()
    {
        Logging.log(Level.INFO, "hello");
        Assert.areEqual("INFO root hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testInfo()
    {
        Logging.info("hello");
        Assert.areEqual("INFO root hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testDebug()
    {
        Logging.debug("hello");
        Assert.areEqual("DEBUG root hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testWarning()
    {
        Logging.warn("hello");
        Assert.areEqual("WARNING root hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testError()
    {
        Logging.error("hello");
        Assert.areEqual("ERROR root hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testCritical()
    {
        Logging.critical("hello");
        Assert.areEqual("CRITICAL root hello", stream.readLine());
    }
}