package logging;

import interpolation.Template;

#if haxe3
import haxe.ds.StringMap;
import haxe.CallStack;
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
    public var arguments(default, null):StringMap<Dynamic>;
    public var stack(default, null):Array<StackItem>;
    public var stackText:String;
    public var func(default, null):String;
    public var asctime(default, default):String;
    public var created(default, null):Int;
    public var millisecond(default, null):Int;

    public function new(name:String, level:Int, pathname:String, lineno:Int,
                        message:String, arguments:Dynamic,
                        ?stack:Array<StackItem>) /*fuc:String*/
    {
        this.name = name;
        this.level = level;
        this.levelname = Level.getName(level);
        this.levelno = level;
        this.pathname = pathname;
        this.lineno = lineno;
        this.created = Std.int(Date.now().getTime() / 1000);
        this.millisecond = Std.int((haxe.Timer.stamp() - this.created) * 1000);

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
        this.stack = stack;
        /*
        this.func = func;
        */
    }

    function cloneStringMap<T>(hash:StringMap<T>):StringMap<T>
    {
        var cloned:StringMap<T> = new StringMap<T>();
        if (null != hash)
            for (key in hash.keys())
                cloned.set(key, hash.get(key));

        return cloned;
    }

    public function toStringMap():StringMap<String>
    {
        var context = cloneStringMap(arguments);
        var keys = ["name", "level", "levelno", "levelname", "pathname",
                    "lineno", "message", "arguments", "asctime", "created",
                    "millisecond"];

        for (key in keys)
            context.set(key, Reflect.field(this, key));
        return context;
    }

    public function toString():String
    {
        return "";
    }
}