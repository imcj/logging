package logging;

import haxe.macro.Expr;
import haxe.macro.Context;

class Tools
{
    #if macro
    static inline function expression(definition:ExprDef):Expr
    {
        return {
            pos: Context.currentPos(),
            expr: definition
        };
    }

    static inline function _log(object:Dynamic, level:Expr, message:Expr, 
        ?arguments:Expr=null):Expr
    {
        var position = Context.currentPos();
        var parameters:Array<Expr> = [{
            pos: position,
            expr: EConst(CString(Context.getLocalModule()))
        }];

        var logger = expression(EField(
            expression(EField(
                expression(EConst(CIdent("logging"))),"Logging")),
            "getLogger"));
        
        return expression(ECall(
            expression(EField(expression(ECall(logger, parameters)), "log")),
            [level, message, arguments]
            ));
    }

    static inline function getLevel(level:String):Expr
    {
        return expression(EField(
            expression(EField(
                expression(EConst(CIdent("logging"))), "Level")), level));
    }
    #end

    macro static public function info(object:Dynamic, message:Expr, 
        ?arguments:Expr=null):Expr
    {
        return _log(object, getLevel("INFO"), message, arguments);
    }

    macro static public function debug(object:Dynamic, message:Expr, 
        ?arguments:Expr=null):Expr
    {
        return _log(object, getLevel("DEBUG"), message, arguments);
    }

    macro static public function warning(object:Dynamic, message:Expr, 
        ?arguments:Expr=null):Expr
    {
        return _log(object, getLevel("WARNING"), message, arguments);
    }

    macro static public function warn(object:Dynamic, message:Expr, 
        ?arguments:Expr=null):Expr
    {
        return _log(object, getLevel("WARNING"), message, arguments);
    }

    macro static public function error(object:Dynamic, message:Expr, 
        ?arguments:Expr=null):Expr
    {
        return _log(object, getLevel("ERROR"), message, arguments);
    }

    macro static public function critical(object:Dynamic, message:Expr, 
        ?arguments:Expr=null):Expr
    {
        return _log(object, getLevel("CRITICAL"), message, arguments);
    }

    macro static public function fatal(object:Dynamic, message:Expr, 
        ?arguments:Expr=null):Expr
    {
        return _log(object, getLevel("FATAL"), message, arguments);
    }

    macro static public function log(object:Dynamic, level:Expr, message:Expr, 
        ?arguments:Expr=null):Expr
    {
        return _log(object, level, message, arguments);
    }
}