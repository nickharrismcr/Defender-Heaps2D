
import states.npc.baiter.Materialize;
import states.npc.baiter.Chase;
import states.npc.baiter.Die;
import states.npc.lander.Materialize;
import states.npc.lander.Search;
import states.npc.lander.Die;

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
import systems.PosSystem;

import GFX;
import Planet;
import Camera;
import event.MessageCentre;
import logging.Logging;

class Game
{
    public static var camera_pos:Float;

    var engine:Engine;
    var app:hxd.App;
    var graphics:GFX;
    var planet:Planet;
    var landers:Int=0;
    var landers_killed:Int=0;
    var tf:h2d.Text;

    public function new(app:hxd.App)
    {
        Camera.position = Config.settings.world_width/2;

        this.app=app;
        this.engine=new Engine(app,this);

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
        var pos_sys = new PosSystem();
        this.engine.addUpdateSystem(pos_sys);

        var fsm_sys = new FSMSystem();
        // register a state object with the fcm system
        fsm_sys.register(new states.npc.baiter.Materialize());
        fsm_sys.register(new states.npc.baiter.Chase());
        fsm_sys.register(new states.npc.baiter.Die());
        fsm_sys.register(new states.npc.lander.Materialize());
        fsm_sys.register(new states.npc.lander.Search());
        fsm_sys.register(new states.npc.lander.Die());
        fsm_sys.register(new states.npc.human.Walk());
        fsm_sys.register(new states.npc.human.Die());
        var stree = new StateTree();
        stree.addTransition(Baiter(Materialize),Baiter(Chase));
        stree.addTransition(Baiter(Chase),Baiter(Die));
        stree.addTransition(Lander(Materialize),Lander(Search));
        stree.addTransition(Lander(Search),Lander(Die));
        stree.addTransition(Human(Walk),Human(Die));
        fsm_sys.setStateTree(stree);
        this.engine.addUpdateSystem(fsm_sys);
       
        MessageCentre.register(FireBullet,bullet_sys.fireEvent);
        MessageCentre.register(Killed,this.kill);
       
        GFX.init();
        this.planet=new Planet(this.app.s2d);

        var f=this.instantiate_baiters(1);
        this.engine.schedule(4,f);
        this.landers+=20;
        var f=this.instantiate_landers(this.landers);
        this.engine.schedule(1,f);
        var f=this.instantiate_humans(20 );
        this.engine.schedule(1,f);

        var f=this.instantiate_stars(50);
        this.engine.schedule(0.1,f);

        var font : h2d.Font = hxd.res.DefaultFont.get();
        this.tf = new h2d.Text(font);
        this.tf.text = "";
        this.tf.textAlign = Center;
        this.tf.setPosition(100,100);
 
        this.app.s2d.addChild(this.tf);
    }

    public function mountainAt(pos:Int):Int
    {
        return this.planet.at(pos);
    }

    public function update(dt:Float)
    {
        if (this.planet != null) this.planet.draw( );
        this.engine.update(dt);
        this.engine.draw (dt);
        Camera.update();
        this.debug_update(dt);
        
        // move to player state  
        if ( hxd.Key.isDown(hxd.Key.LEFT)) Camera.position -= 500*dt;
        if ( hxd.Key.isDown(hxd.Key.RIGHT)) Camera.position += 500*dt;
        
        // move to game state 
        if (this.landers_killed == this.landers || hxd.Key.isPressed(hxd.Key.SPACE) ) 
            this.engine.schedule(2,() -> hxd.System.exit());
    }

    private function debug_update(dt:Float)
    {
        var fps=Std.int(1/dt);
        this.tf.text = '${fps}  ${Std.int(Camera.position)}';
    }

  

    private function kill(ev:IEvent)
    {
        var e = ev.entity;
        var ef:FSMComponent = cast e.get(FSM);
        switch (ef.state) {
            case Baiter(_): ef.next_state = Baiter(Die);
            case Human(_): ef.next_state = Human(Die);
            case Lander(_): { ef.next_state = Lander(Die); this.landers--; };
            case _ : 
        }
    }

    private function instantiate_baiters(n:Int)
    {
        
        return () -> {

            for ( i in 0...n )
            {   
                var e = new Entity();
                var pc = new PosComponent();
                e.addComponent(pc);
                var fc = new FSMComponent(Baiter(Materialize));
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
                var e = new Entity();   
                var pc = new PosComponent();
                e.addComponent(pc);
                var fc = new FSMComponent(Lander(Materialize));
                e.addComponent(fc);
                var tc = new TimerComponent();
                e.addComponent(tc);
                var cc = new CollideComponent();
                e.addComponent(cc);
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

    private function instantiate_humans(n:Int)
    {
        
        return () -> {
            for ( i in 0...n )
            {
                var e = new Entity();   
                var pc = new PosComponent();
                e.addComponent(pc);
                var fc = new FSMComponent(Human(Walk));
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

        
    
}