package logging;

// import ;
import logging.Logging;
import logging.handlers.StreamHandler;

class SocketHandlerTest
{
    @Test
    @TestDebug
    public function testSocketHandler()
    {
        var logger = Logging.getLogger("me.imcj.SocketHandler");
        var handler = new logging.handlers.SocketHandler("127.0.0.1:8800");
        logger.addHandler(handler);

        logger.info("hello");
    }
}