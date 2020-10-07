import ecs.Entity;
import ecs.Engine;

import components.update.CollideComponent;
import components.update.ShootableComponent;
import components.update.StarComponent;
import components.update.TimerComponent;
import components.update.PosComponent;
import components.update.HumanComponent;
import components.update.HumanFinderComponent;
import components.update.LifeComponent;
import components.update.PlayerComponent;
import components.draw.RadarDrawComponent;
import components.draw.DrawComponent;
import fsm.FSMComponent;

class Factory
{
    var ecs:Engine;
    public var radartile:h2d.Tile;

    public function new(ecs:Engine)
    {
        this.ecs = ecs;
        this.radartile = h2d.Tile.fromColor(0xffffff,6,3);
    }

    public function addScore(n:Int, x:Float, y:Float, dx:Float, dy:Float ){
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
 

    public function addPlayer()
        {        
            return () -> {
    
                var e = new Entity();
                var dc = new RadarDrawComponent(this.radartile,Player);
                e.addComponent(dc);
                var fc = new FSMComponent(Player(Play));
                e.addComponent(fc);
                var tc = new TimerComponent();
                e.addComponent(tc);
                var cc = new CollideComponent();
                e.addComponent(cc);
                var pc = new PlayerComponent();
                e.addComponent(pc);
                this.ecs.addEntity(e);
                
            } ;
        }
    

    public function addBaiters(n:Int)
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

    public function addLanders(n:Int)
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

    public function addStars(n:Int)
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

    public function add_humans(n:Int)
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