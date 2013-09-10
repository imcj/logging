package logging;

class ManagerTest
{
    @Test
    function testGetLogger()
    {
        var l1 = Logging.getLogger("com.indvane");
    }
}