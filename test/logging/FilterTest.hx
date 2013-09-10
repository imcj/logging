package logging;

import massive.munit.Assert;

class FilterTest
{
    var record:LogRecord;

    @Before
    public function setUp()
    {
        record = new LogRecord("me.imcj.FilterTest", 10, "pathname", 0,
                                   "${name}", {name: "CJ"});
    }

    @Test
    @TestDebug
    public function testFilter()
    {
        var filter:IFilter = new Filter("me.imcj");
        Assert.areEqual(true, filter.filter(record));
    }

    @Test
    @TestDebug
    public function testFilterRecordNameAreEqual()
    {
        var filter:IFilter = new Filter("me.imcj.FilterTest");
        Assert.areEqual(true, filter.filter(record));
    }

    @Test
    @TestDebug
    public function testFilterFailure()
    {
        var filter:IFilter = new Filter("com.imcj");
        Assert.areEqual(false, filter.filter(record));
    }

    @Test
    @TestDebug
    public function testFilterIsEmpty()
    {
        var filter:IFilter = new Filter("");
        Assert.areEqual(true, filter.filter(record));
    }

    @Test
    @TestDebug
    public function testFilterChildArePass()
    {
        var filter:IFilter = new Filter("me.imcj");
        Assert.areEqual(true, filter.filter(record));
    }
}