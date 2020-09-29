package ecs;

class Util
{
    public static function klass<T>(c:T):String
    {
        return Type.getClassName(Type.getClass(c));
    }
}