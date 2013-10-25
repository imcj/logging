logging
========

logging是Python logging的移植，再造轮子是因为mconsole没有提供过滤日志的接口。

安装
----

	$ haxelib install loggin

or

	$ haxelib git logging https://github.com/imcj/logging

使用方法
--------

和所有的日志一样，提供一个静态的输出方法。

	import logging.Logging.info;

    info("hello");
    
Logging.info方法用root logger输出内容，和下面的代码是等价的。

	import logging.Logging;
	
	var logger = Logging.getLogger()"root");
	logger.info("hello");
	
	logger = Logging.getLogger("");
	logger.info("hello");

Logger.disable 可以禁用这个Logger，关闭Logger的日志输出，更加高级的办法是使用`logging.Filter`对象，之后详细说明。

	import logging.Logging;
	
    var logger = Logging.getLogger("me.imcj");
    logger.disable = true;
    
利用Socket接收手机发来的日志。

客户端

	var logger = Logging.getLogger('me.imcj.socket');
	var address = "localhost:8800";
	logger.addHandler(new logging.handlers.SocketHandler(address));
	
	logger.info("hello");
	
服务端

这个是简单版本，用nc监听一个端口接收并输出日志，这是我的开发场景，开发机是mbp，把日志输出到24寸的显示器上。

	$ while true; do nc -l 8800|tee -a debug.log; done

    
TODO
----

- Logger.getChild 方法。
- 利用宏在编译器剔除Log代码。
- <del>格式化堆栈信息。</del>
- <del>兼容 Haxe 3。</del>
- [logging-monitor](https://github.com/imcj/logging-monitor)
- More handler:
	- FileHandler
	- NullHandler
	- WatchedFileHandler
	- BaseRotatingHandler
	- RotatingFileHandler
	- TimedRotatingFileHandler
	- <del>SocketHandler</del>
	- DatagramHandler
	- SysLogHandler
	- NTEventLogHandler
	- SMTPHandler
	- MemoryHandler
	- HTTPHandler
	- QueueHandler

贡献
----

* [@imcj](https://github.com/imcj/)

Changelog
---------

* 0.1.3 格式化信息中加入`filename`和`lineno`，log第三个参数可打印堆栈
* 0.1.2 兼容 Haxe 3。
* 0.1.1 新增SocketHandler
* 0.1.0 完成一个基本可用的日志模块。