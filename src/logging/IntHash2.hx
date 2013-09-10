package logging;

class IntHash2<T> extends IntHash<T>
{
    override public function toString():String
    {
        // disable toString
        // 不知道什么位置隐式调用了toString导致死循环
        return ""; 
    }
}