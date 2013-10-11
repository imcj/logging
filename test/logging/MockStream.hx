package logging;

import haxe.io.Bytes;
import haxe.io.Input;

class MockStream extends haxe.io.Output
{
    var buffer:String;
    var offset:Int;

    public function new()
    {
        buffer = "";
        offset = 0;
    }

    override public function close():Void {}
    override public function flush():Void {}
    override public function prepare(nbytes:Int):Void {}
    override public function write(s:Bytes):Void {}
    override public function writeByte(c:Int):Void {}
    override public function writeBytes(s:Bytes, pos:Int, len:Int):Int {
        return 0;
    }
    override public function writeDouble(x:Float):Void {}
    override public function writeFloat(x:Float):Void {}
    override public function writeFullBytes(s:Bytes, pos:Int, len:Int):Void {}
    override public function writeInput(i:Input, ?bufsize:Int):Void {}
    override public function writeInt16(x:Int):Void {}
    override public function writeInt24(x:Int):Void {}
    override public function writeInt32(x:Int):Void {}
    override public function writeInt8(x:Int):Void {}
    override public function writeString(s:String):Void
    {
        buffer += s;
    }

    override public function writeUInt16(x:Int):Void {}
    override public function writeUInt24(x:Int):Void {}

    public function read(nbytes:Int):Bytes { return null; }
    public function readAll(?bufsize:Int):Bytes { return null; }
    public function readByte():Int { return 0; }
    public function readBytes(s:Bytes, pos:Int, len:Int):Int { return 0; }
    public function readDouble():Float { return 0; }
    public function readFloat():Float { return 0; }
    public function readFullBytes(s:Bytes, pos:Int, len:Int):Void {}
    public function readInt16():Int { return 0; }
    public function readInt24():Int { return 0; }
    public function readInt32():Int { return 0; }
    public function readInt8():Int { return 0; }
    public function readLine():String
    {
        var point_of_line = buffer.indexOf("\n", offset);
        var s =  buffer.substr(offset, point_of_line);
        offset += point_of_line;
        return s;
    }

    public function readString(len:Int):String
    {
        var s = buffer.substr(offset, len);
        offset += len;
        return s;
    }
    public function readUInt16():Int { return 0; }
    public function readUInt24():Int { return 0; }
    public function readUInt30():Int { return 0; }
    public function readUntil(end:Int):String { return "";}

    function getDoubleSig(value):Int
    {
        return 0;

    }
}