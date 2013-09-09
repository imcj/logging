package logging;

#if haxe3
typedef StringMap<T> = haxe.ds.StringMap<T>;
#else
typedef StringMap<T> = Hash2<T>;
#end