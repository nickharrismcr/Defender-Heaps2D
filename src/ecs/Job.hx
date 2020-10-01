package ecs;

class Job
{
    public var scheduled_time:Float;
    public var func:()->Void;

    public function new(sched_time:Float, func:()->Void)
    {
        this.scheduled_time=sched_time;
        this.func=func;
    }
}