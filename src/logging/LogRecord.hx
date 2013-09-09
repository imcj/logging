package logging;

import interpolation.Template;

#if haxe3
import haxe.ds.StringMap;
#else
private typedef StringMap<T> = Hash<T>;
#end

class LogRecord
{
	public var name(default, null):String;
	public var level(default, null):Int;
	public var levelno(default, null):Int;
	public var levelname(default, null):String;
	public var pathname(default, null):String;
	public var lineno(default, null):Int;
	public var message(default, null):String;
	public var arguments(default, null):Array<Dynamic>;
	public var exc_info(default, null):String;
	public var func(default, null):String;

	public function new(name:String, level:Int, pathname:String, lineno:Int,
						message:String, arguments:Dynamic)/*,
						exc_info:String, fuc:String*/
	{
		this.name = name;
		this.level = level;
		this.pathname = pathname;
		this.lineno = lineno;

		var _arguments:StringMap<Dynamic>;
		if (null == arguments) {
			this.message = message;
		} else {
			var template = new Template(message);
			switch (Type.typeof(arguments)) {
				case TObject:
					_arguments = new StringMap<Dynamic>();
					for (key in Reflect.fields(arguments)) {
						_arguments.set(key, Reflect.field(arguments, key));
					}
					arguments = _arguments;
				case TClass(c):
					if (!Std.is(arguments, StringMap))
						throw "Argument type requirement StringMap";
				default:
					throw "Argument type requirement StringMap";
			}
			this.message = template.safe_substitute(arguments);
		}
		this.arguments = arguments;
		/*
		this.exc_info = exc_info;
		this.func = func;
		*/
	}

	public function toString():String
	{
		return Std.format("<LogRecord %>");
	}
}