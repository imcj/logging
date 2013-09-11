package logging.handlers;

import logging.handlers.socket.FlashSocketHandler;
import logging.handlers.socket.ThreadSocketHandler;

#if flash
typedef SocketHandler = FlashSocketHandler;
#elseif (neko || cpp || php)
typedef SocketHandler = ThreadSocketHandler;
#else
typedef SocketHandler = logging.handlers.socket.BaseSocketHandler;
#end