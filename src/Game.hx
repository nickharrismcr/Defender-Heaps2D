import GFX;
import components.update.TimerComponent;
import systems.TimerSystem;
import fsm.StateTree;
import fsm.FSMSystem;
import fsm.FSMComponent;
import components.update.PosComponent;
import ecs.Entity;
import components.draw.DrawComponent;
import ecs.Engine;
import systems.DrawSystem;
import states.TestMove;
import states.TestStop;

import logging.Logging;

class Game
{
    var engine:Engine;
    var app:hxd.App;
    var graphics:GFX;
     

    public function new(app:hxd.App)
    {
        this.app=app;
        this.engine=new Engine(app);
        var draw_sys = new DrawSystem();
        this.engine.addDrawSystem(draw_sys);
        var fsm_sys = new FSMSystem();
        // register a state object with the fcm system
        fsm_sys.register(new TestMove());
        fsm_sys.register(new TestStop());
        var stree = new StateTree();
        stree.addTransition(TestMove,TestStop);
        stree.addTransition(TestStop,TestMove);
        fsm_sys.setStateTree(stree);
        this.engine.addUpdateSystem(fsm_sys);
        var timer_sys = new TimerSystem();
        this.engine.addUpdateSystem(timer_sys);

        this.graphics = new GFX();
        this.graphics.load("baiter.png",2,11,4);
        this.graphics.load("lander.png",3,8,9);
        this.graphics.load("mutant.png",5,8,9);
        this.graphics.load("swarmer.png",1,5,4);

       
        var f=this.instantiate(20);
        for ( i in 1...20 ){
            this.engine.schedule(i,f);
        }
    }

    public function update(dt:Float)
    {
        this.engine.update(dt);
        this.engine.draw (dt);
    }

    private function instantiate(n:Int)
    {
        return () -> {
            for ( i in 1...n )
            {
                var dc = new DrawComponent(this.graphics.get('lander.png',5));
                var e = new Entity();
                e.addComponent(dc);
                var pc = new PosComponent();
                e.addComponent(pc);
                var fc = new FSMComponent(TestMove);
                e.addComponent(fc);
                var tc = new TimerComponent();
                e.addComponent(tc);
                this.engine.addEntity(e);
            }
        } ;
    }

    
}