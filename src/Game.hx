import components.update.CollideComponent;
import components.update.ShootableComponent;
import components.update.StarComponent;
import components.update.TimerComponent;
import components.update.PosComponent;
import components.draw.DrawDisperseComponent;
import components.draw.DrawComponent;

import fsm.StateTree;
import fsm.FSMSystem;
import fsm.FSMComponent;

import ecs.Entity;
import ecs.Engine;

import systems.DrawDisperseSystem;
import systems.DrawSystem;
import systems.TimerSystem;
import systems.StarSystem;
import systems.BulletSystem;

import GFX;
import Planet;
import event.MessageCentre;
import logging.Logging;

class Game
{
    var engine:Engine;
    var app:hxd.App;
    var graphics:GFX;
    var planet:Planet;
    var landers:Int=0;
    var landers_killed:Int=0;
    var campos:Float;

    public function new(app:hxd.App)
    {
        this.app=app;
        this.engine=new Engine(app);

        var draw_sys = new DrawSystem();
        this.engine.addDrawSystem(draw_sys);
        var dispdraw_sys = new DrawDisperseSystem();
        this.engine.addDrawSystem(dispdraw_sys);
        var timer_sys = new TimerSystem();
        this.engine.addUpdateSystem(timer_sys);
        var star_sys = new StarSystem(this.app.s2d);
        this.engine.addUpdateSystem(star_sys);
        var bullet_sys = new BulletSystem();
        this.engine.addUpdateSystem(bullet_sys);

        var fsm_sys = new FSMSystem();
        // register a state object with the fcm system
        fsm_sys.register(new states.npc.baiter.Chase());
        fsm_sys.register(new states.npc.baiter.Die());
        fsm_sys.register(new states.npc.lander.Search());
        fsm_sys.register(new states.npc.lander.Die());
        var stree = new StateTree();
        stree.addTransition(Baiter(Chase),Baiter(Die));
        stree.addTransition(Baiter(Die),Baiter(Chase));
        stree.addTransition(Lander(Search),Lander(Die));
        stree.addTransition(Lander(Die),Lander(Search));
        fsm_sys.setStateTree(stree);
        this.engine.addUpdateSystem(fsm_sys);
       
        MessageCentre.register(FireBullet,bullet_sys.fireEvent);
        MessageCentre.register(Killed,this.kill);
        GFX.init();
        this.engine.schedule(0.1, () -> this.planet=new Planet(this.app.s2d));

        var f=this.instantiate_baiters(1);
        this.engine.schedule(4,f);
        this.landers+=20;
        var f=this.instantiate_landers(20);
        this.engine.schedule(1,f);

        var f=this.instantiate_stars(50);
        this.engine.schedule(0.1,f);

        this.campos=0;
    }

    public function update(dt:Float)
    {
        this.engine.update(dt);
        this.engine.draw (dt);
        if (this.planet != null) this.planet.draw(campos);
        campos--;

        if (this.landers_killed == this.landers || hxd.Key.isPressed(hxd.Key.SPACE) ) 
            this.engine.schedule(2,() -> hxd.System.exit());
    }

    private function kill(ev:IEvent)
    {
        var e = ev.entity;
        var ef:FSMComponent = cast e.get(FSM);
        switch (ef.state) {
            case Baiter(_): ef.next_state = Baiter(Die);
            case Lander(_): { ef.next_state = Lander(Die); this.landers--; };
            case _ : 
        }
    }

    private function instantiate_baiters(n:Int)
    {
        
        return () -> {

            for ( i in 0...n )
            {
                var dc = new DrawComponent(GFX.getAnim(Baiter));
                var e = new Entity();
                e.addComponent(dc);
                var pc = new PosComponent();
                e.addComponent(pc);
                var fc = new FSMComponent(Baiter(Chase));
                e.addComponent(fc);
                var tc = new TimerComponent();
                e.addComponent(tc);
                var cc = new CollideComponent();
                e.addComponent(cc);
                this.engine.addEntity(e);
            }
        } ;
    }

    private function instantiate_landers(n:Int)
    {
        
        return () -> {
            for ( i in 0...n )
            {
                var dc = new DrawComponent(GFX.getAnim(Lander));
                var e = new Entity();
                e.addComponent(dc);
                var pc = new PosComponent();
                e.addComponent(pc);
                var fc = new FSMComponent(Lander(Search));
                e.addComponent(fc);
                var tc = new TimerComponent();
                e.addComponent(tc);
                var cc = new CollideComponent();
                e.addComponent(cc);
                var sc = new ShootableComponent();
                e.addComponent(sc);
                this.engine.addEntity(e);
            }
        } ;
    }

    private function instantiate_stars(n:Int)
    {
        return () -> {
            for ( i in 1...n ){
                var s = new StarComponent();
                var p = new PosComponent();
                var t = new TimerComponent();
                var e = new Entity();
                e.addComponent(s);
                e.addComponent(p);
                e.addComponent(t);
                this.engine.addEntity(e);
            }
        };
    }
    
}