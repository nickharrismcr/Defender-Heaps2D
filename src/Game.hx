import event.events.HumanSaved.HumanSavedEvent;
import event.events.HumanLanded.HumanLandedEvent;
import event.events.HumanPlaced.HumanPlacedEvent;

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
import components.update.HumanComponent;
import components.update.HumanFinderComponent;
import components.update.LifeComponent;
import components.draw.RadarDrawComponent;
import components.draw.DrawComponent;

import fsm.StateTree;
import fsm.FSMSystem;
import fsm.FSMComponent;

import ecs.Entity;
import ecs.Engine;

import systems.DrawDisperseSystem;
import systems.DrawSystem;
import systems.RadarDrawSystem;
import systems.TimerSystem;
import systems.StarSystem;
import systems.BulletSystem;
import systems.PosSystem;
import systems.LifeSystem;

import GFX;
import Planet;
import Camera;

import hxd.Window.DisplayMode;
 
class Game extends hxd.App
{
    public static var camera_pos:Float;

    var ecs:ecs.Engine;
    var app:hxd.App;
    var graphics:GFX;
    var planet:Planet;
    var landers:Int=0;
    var landers_killed:Int=0;
    var tf:h2d.Text;
    var radartile:h2d.Tile;

    public function new()
    { 
        super();
        
    }

    public override function init()
    {
        var win=hxd.Window.getInstance();
        #if !debug
        win.displayMode = Fullscreen;
        Logging.level = ERROR;
        #end
		
        Camera.position = Config.settings.world_width/2;

        this.ecs=new ecs.Engine(this);

        var draw_sys = new DrawSystem();
        this.ecs.addDrawSystem(draw_sys);
        var radardraw_sys = new RadarDrawSystem(this.s2d);
        this.ecs.addDrawSystem(radardraw_sys);
        var dispdraw_sys = new DrawDisperseSystem();
        this.ecs.addDrawSystem(dispdraw_sys);
        var timer_sys = new TimerSystem();
        this.ecs.addUpdateSystem(timer_sys);
        var star_sys = new StarSystem(s2d);
        this.ecs.addUpdateSystem(star_sys);
        var bullet_sys = new BulletSystem();
        this.ecs.addUpdateSystem(bullet_sys);
        var pos_sys = new PosSystem();
        this.ecs.addUpdateSystem(pos_sys);
        var life_sys = new LifeSystem();
        this.ecs.addUpdateSystem(life_sys);

        var fsm_sys = new FSMSystem();
        // register a state object with the fcm system
        fsm_sys.register(new states.npc.baiter.Materialize());
        fsm_sys.register(new states.npc.baiter.Chase());
        fsm_sys.register(new states.npc.baiter.Die());
        fsm_sys.register(new states.npc.lander.Materialize());
        fsm_sys.register(new states.npc.lander.Search());
        fsm_sys.register(new states.npc.lander.Pounce());
        fsm_sys.register(new states.npc.lander.Kidnap());
        fsm_sys.register(new states.npc.lander.Mutant());
        fsm_sys.register(new states.npc.lander.Die());
        fsm_sys.register(new states.npc.human.Walk());
        fsm_sys.register(new states.npc.human.Grabbed());
        fsm_sys.register(new states.npc.human.Falling());
        fsm_sys.register(new states.npc.human.Die());
        var stree = new StateTree();
        
        stree.addTransition(Baiter(Materialize),Baiter(Chase));
        stree.addTransition(Baiter(Chase),Baiter(Die));

        stree.addTransition(Lander(Materialize),Lander(Search));
        stree.addTransition(Lander(Search),Lander(Die));
        stree.addTransition(Lander(Search),Lander(Pounce));
        stree.addTransition(Lander(Pounce),Lander(Die));
        stree.addTransition(Lander(Pounce),Lander(Search));
        stree.addTransition(Lander(Pounce),Lander(Kidnap));
        stree.addTransition(Lander(Kidnap),Lander(Search));
        stree.addTransition(Lander(Kidnap),Lander(Die));
        stree.addTransition(Lander(Kidnap),Lander(Mutant));
        stree.addTransition(Lander(Mutant),Lander(Die));

        stree.addTransition(Human(Walk),Human(Die));
        stree.addTransition(Human(Walk),Human(Grabbed));
        stree.addTransition(Human(Grabbed),Human(Die));
        stree.addTransition(Human(Grabbed),Human(Falling));
        stree.addTransition(Human(Falling),Human(Die));
        stree.addTransition(Human(Falling),Human(Walk));
        
        fsm_sys.setStateTree(stree);
        this.ecs.addUpdateSystem(fsm_sys);
       
        MessageCentre.register(FireBullet,bullet_sys.fireEvent);
        MessageCentre.register(Killed,this.kill);
        MessageCentre.register(HumanLanded,this.score250);
        MessageCentre.register(HumanSaved,this.score500);
        MessageCentre.register(HumanPlaced,this.score500);

       
        GFX.init();
        this.radartile = h2d.Tile.fromColor(0xffffff,6,3);
        this.planet=new Planet(s2d);

        var f=this.addBaiters(1);
        this.ecs.schedule(4,f);
        this.landers+=20;
        var f=this.addLanders(this.landers);
        this.ecs.schedule(1,f);
        var f=this.add_humans(20 );
        this.ecs.schedule(1,f);

        var f=this.addStars(50);
        this.ecs.schedule(0.1,f);

        // FPS 
        var font : h2d.Font = hxd.res.DefaultFont.get();
        this.tf = new h2d.Text(font);
        this.tf.text = "";
        this.tf.textAlign = Center;
        this.tf.setPosition(100,100);
 
        s2d.addChild(this.tf);
    }

    public function mountainAt(pos:Int):Int
    {
        return this.planet.at(pos);
    }

    public override function update(dt:Float)
    {
        if (this.planet != null) this.planet.draw( );
        this.ecs.update(dt);
        this.ecs.draw (dt);
        Camera.update();
        this.debugUpdate(dt);
        
        // TODO move to player state  
        if ( hxd.Key.isDown(hxd.Key.LEFT)) Camera.position -= 1500*dt;
        if ( hxd.Key.isDown(hxd.Key.RIGHT)) Camera.position += 1500*dt;
        
        // TODO move to game state 
        if (this.landers_killed == this.landers || hxd.Key.isPressed(hxd.Key.SPACE) ) 
            this.ecs.schedule(2,() -> hxd.System.exit());
    }

    private function debugUpdate(dt:Float)
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

    private function score250(ev:IEvent)
    {
        var ev:HumanLandedEvent = cast ev;
        this.addScore(250,ev.pos.x,ev.pos.y,0,0);
    }

    private function score500(ev:IEvent)
    {
        switch (ev.type) 
        {
            case HumanSaved : { 
                var ev:HumanSavedEvent = cast ev;
                this.addScore(500,ev.pos.x,ev.pos.y,0,0);
            }
            case HumanPlaced : { 
                var ev:HumanPlacedEvent = cast ev;
                this.addScore(500,ev.pos.x,ev.pos.y,0,0);
            }
            case _: {}   
        }    
    }

    private function addScore(n:Int, x:Float, y:Float, dx:Float, dy:Float ){
        var e = new Entity();
        var anim = if (n==250) Score250 else Score500; 
        var dc = new DrawComponent(GFX.getAnim(anim));
        e.addComponent(dc);
        var pc = new PosComponent();
        pc.x = x;
        pc.y = y;
        pc.dx = dx;
        pc.dy = dy; 
        e.addComponent(pc);
        var lc = new LifeComponent(3);
        e.addComponent(lc);
        this.ecs.addEntity(e);
    }
 

    private function addBaiters(n:Int)
    {
        
        return () -> {

            for ( i in 0...n )
            {   
                var e = new Entity();
                var dc = new RadarDrawComponent(this.radartile,Baiter);
                e.addComponent(dc);
                var pc = new PosComponent();
                e.addComponent(pc);
                var fc = new FSMComponent(Baiter(Materialize));
                e.addComponent(fc);
                var tc = new TimerComponent();
                e.addComponent(tc);
                var cc = new CollideComponent();
                e.addComponent(cc);
                this.ecs.addEntity(e);
            }
        } ;
    }

    private function addLanders(n:Int)
    {
        
        return () -> {
            for ( i in 0...n )
            {
                var e = new Entity();  
                var rdc = new RadarDrawComponent(this.radartile,Lander);
                e.addComponent(rdc); 
                var pc = new PosComponent();
                e.addComponent(pc);
                var fc = new FSMComponent(Lander(Materialize));
                e.addComponent(fc);
                var tc = new TimerComponent();
                e.addComponent(tc);
                var cc = new CollideComponent();
                e.addComponent(cc);
                var hc = new HumanFinderComponent();
                e.addComponent(hc);
                this.ecs.addEntity(e);
            }
        } ;
    }

    private function addStars(n:Int)
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
                this.ecs.addEntity(e);
            }
        };
    }

    private function add_humans(n:Int)
    {
        
        return () -> {
            for ( i in 0...n )
            {
                var e = new Entity();  
                var dc = new RadarDrawComponent(this.radartile,Human);
                e.addComponent(dc); 
                var pc = new PosComponent();
                e.addComponent(pc);
                var fc = new FSMComponent(Human(Walk));
                e.addComponent(fc);
                var tc = new TimerComponent();
                e.addComponent(tc);
                var cc = new CollideComponent();
                e.addComponent(cc);
                //var sc = new ShootableComponent();
                //e.addComponent(sc);
                var hc = new HumanComponent();
                e.addComponent(hc);
                this.ecs.addEntity(e);
            }
        } ;
    }     
}