package logging;

import massive.munit.Assert;
import logging.handlers.StreamHandler;

class LoggerTest
{
    var record:LogRecord;
    var logger:ILogger;
    var stream:MockStream;

    @Before
    public function setUp()
    {
        record = new LogRecord("name", 10, "pathname", 0, "${name}", 
            {name: "CJ"});
        stream = new MockStream();
        var handler = new StreamHandler(stream);
        logger = Logging.getLogger("me.imcj.LoggerTest");
        logger.addHandler(handler);
        logger.addFilter(new Filter("me.imcj"));
    }

    @Test
    @TestDebug
    public function testLog()
    {
        logger.log(Level.INFO, "hello");
        Assert.areEqual("INFO me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testInfo()
    {
        logger.info("hello");
        Assert.areEqual("INFO me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testDebug()
    {
        logger.debug("hello");
        Assert.areEqual("DEBUG me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testWarning()
    {
        logger.warn("hello");
        Assert.areEqual("WARNING me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testError()
    {
        logger.error("hello");
        Assert.areEqual("ERROR me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    @TestDebug
    public function testCritical()
    {
        logger.critical("hello");
        Assert.areEqual("CRITICAL me.imcj.LoggerTest hello", stream.readLine());
    }
}