package logging;

import haxe.io.Bytes;
import haxe.io.Input;

class MockStream implements haxe.io.Output, implements haxe.io.Input
{
    var buffer:String;
    var offset:Int;

    public function new()
    {
        buffer = "";
        offset = 0;
    }

    public var bigEndian(default,setEndian):Bool;
    public function close():Void {}
    public function flush():Void {}
    public function prepare(nbytes:Int):Void {}
    public function write(s:Bytes):Void {}
    public function writeByte(c:Int):Void {}
    public function writeBytes(s:Bytes, pos:Int, len:Int):Int {
        return 0;
    }
    public function writeDouble(x:Float):Void {}
    public function writeFloat(x:Float):Void {}
    public function writeFullBytes(s:Bytes, pos:Int, len:Int):Void {}
    public function writeInput(i:Input, ?bufsize:Int):Void {}
    public function writeInt16(x:Int):Void {}
    public function writeInt24(x:Int):Void {}
    public function writeInt31(x:Int):Void {}
    public function writeInt32(x:haxe.Int32):Void {}
    public function writeInt8(x:Int):Void {}
    public function writeString(s:String):Void
    {
        buffer += s;
    }

    public function writeUInt16(x:Int):Void {}
    public function writeUInt24(x:Int):Void {}
    public function writeUInt30(x:Int):Void {}

    public function read(nbytes:Int):Bytes { return null; }
    public function readAll(?bufsize:Int):Bytes { return null; }
    public function readByte():Int { return 0; }
    public function readBytes(s:Bytes, pos:Int, len:Int):Int { return 0; }
    public function readDouble():Float { return 0; }
    public function readFloat():Float { return 0; }
    public function readFullBytes(s:Bytes, pos:Int, len:Int):Void {}
    public function readInt16():Int { return 0; }
    public function readInt24():Int { return 0; }
    public function readInt31():Int { return 0; }
    public function readInt32():haxe.Int32 { return haxe.Int32.ofInt(0); }
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

    function setEndian(value:Bool):Bool
    {
        return true;
    }

    function getDoubleSig(value):Int
    {
        return 0;

    }
}