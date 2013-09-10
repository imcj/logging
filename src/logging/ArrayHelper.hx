package logging;

class ArrayHelper
{
    static public function has<T>(array:Array<T>, object:T):Bool
    {
        var found:Bool = false;

        for (item in array) {
            if (item == object) {
                found = true;
                break;
            }
        }
        return found;
    }
}