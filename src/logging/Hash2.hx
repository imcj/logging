package logging;

import haxe.Stack;

class Hash2<T> extends Hash<T>
{
    override public function toString():String
    {
        // disable toString
        // 不知道什么位置隐式调用了toString导致死循环
        return ""; 
    }
}