package logging;

import massive.munit.Assert;
import logging.handlers.StreamHandler;

class LoggerTest
{
    var record:LogRecord;
    var logger:ILogger;
    var stream:MockStream;
    var handler:IHandler;

    @Before
    public function setUp()
    {
        record = new LogRecord("name", 10, "pathname", 0, "${name}", 
            {name: "CJ"});
        stream = new MockStream();
        handler = new StreamHandler(stream);
        logger = Logging.getLogger("me.imcj.LoggerTest");
        logger.addHandler(handler);
        logger.addFilter(new Filter("me.imcj"));
    }

    @Test
    public function testFilter()
    {
        logger.handlers.pop();

        logger.info("hello");
        Assert.areEqual("", stream.readLine());
    }

    @Test
    public function testIsEnableFor()
    {
        logger.level = logging.Level.DEBUG;
        // trace(cast(logger, Logger).isEnableFor(logging.Level.INFO));
    }

    @Test
    public function testLog()
    {
        logger.log(Level.INFO, "hello");
        Assert.areEqual("INFO me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    public function testInfo()
    {
        logger.info("hello");
        Assert.areEqual("INFO me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    public function testInfoHasLineNumber()
    {
        handler.formatter = new Formatter("$levelname $name $pathname:" + 
                                          "$lineno $message");
        logger.info("hello");
        Assert.areEqual("INFO me.imcj.LoggerTest Logger.hx:102 hello", 
            stream.readLine());
    }

    @Test
    @TestDebug
    public function testInfoHasStack()
    {
        logger.info("hello", null, haxe.CallStack.callStack());
        Assert.areEqual(true, stream.readString(0).length >= 30);
    }

    @Test
    public function testDebug()
    {
        logger.debug("hello");
        Assert.areEqual("DEBUG me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    public function testWarning()
    {
        logger.warn("hello");
        Assert.areEqual("WARNING me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    public function testError()
    {
        logger.error("hello");
        Assert.areEqual("ERROR me.imcj.LoggerTest hello", stream.readLine());
    }

    @Test
    public function testCritical()
    {
        logger.critical("hello");
        Assert.areEqual("CRITICAL me.imcj.LoggerTest hello", stream.readLine());
    }
}