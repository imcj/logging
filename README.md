logging
========

logging是Python logging的移植。

使用方法
--------

全新开发logging的动机是因为mconsole没有提供过滤日志的接口。

和所有的日志一样，提供一个静态的输出方法。

    logging.Logging.info("hello");
    
Logging.info方法用root logger输出内容，和下面的代码是等价的。

	import logging.Logging;
	
	var logger = Logging.getLogger()"root");
	logger.info("hello");
	
	logger = Logging.getLogger("");
	logger.info("hello");

可以在任意位置禁用，更加高级的办法是使用`logging.Filter`对象，之后详细说明。

	import logging.Logging;
	
    var logger = Logging.getLogger("me.imcj");
    logger.disable = true;
    
TODO
----

- Logger.getChild 方法。
- 格式化堆栈信息。
- More handler:
	- FileHandler
	- NullHandler
	- WatchedFileHandler
	- BaseRotatingHandler
	- RotatingFileHandler
	- TimedRotatingFileHandler
	- SocketHandler
	- DatagramHandler
	- SysLogHandler
	- NTEventLogHandler
	- SMTPHandler
	- MemoryHandler
	- HTTPHandler
	- QueueHandler

    
Changelog
---------

0.1.0 完成一个基本可用的日志模块。