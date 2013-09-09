package logging;

class ManagerTest
{
    @Test
    @TestDebug
    function testGetLogger()
    {
        var l1 = Logging.getLogger("com.indvane");
        trace(l1.getChild("hello").name);
        // var l2 = Logging.getLogger("com.indvane.june");
        // trace(l2.parent);
    }
}