
import event.events.HumanSaved.HumanSavedEvent;
import event.events.HumanLanded.HumanLandedEvent;
import event.events.HumanPlaced.HumanPlacedEvent;
import states.npc.baiter.Materialize;
import states.npc.baiter.Chase;
import states.npc.baiter.Die;
import states.npc.lander.Materialize;
import states.npc.lander.Search;
import states.npc.lander.Die;
import states.npc.human.Rescued;
import states.player.Play;
import states.player.Die;
import states.game.LevelStart;
import states.game.Level;
import states.game.LevelEnd;
import states.game.GameOver;
import components.update.PosComponent;
import fsm.StateTree;
import fsm.FSMSystem;
import fsm.FSMComponent;
import ecs.Engine;
import systems.DrawDisperseSystem;
import systems.DrawSystem;
import systems.RadarDrawSystem;
import systems.TimerSystem;
import systems.StarSystem;
import systems.BulletSystem;
import systems.PosSystem;
import systems.LifeSystem;
import systems.CollideSystem;
import systems.LaserDrawSystem;
import systems.LaserSystem;
import GFX;
import Planet;
import Camera;
import Factory;
import Hud;
import hxd.Window.DisplayMode;

class Game extends hxd.App {
	public static var camera_pos:Float;

	public var player_pos:PosComponent;
	public var freeze:Bool;
	public var factory:Factory;
	public var landers_killed:Int = 0;
	public var hud:Hud;

	var ecs:ecs.Engine;
	var app:hxd.App;
	var graphics:GFX;
	var planet:Planet;
	var landers:Int = 0;
	var score:Int=0;
	
	var tf:h2d.Text;
	

	public function new() {
		super();
	}

	public override function init() {
		Logging.level = DEBUG;
		#if !debug
		var win = hxd.Window.getInstance();
		win.displayMode = Fullscreen;
		Logging.level = TRACE;
		#end

		Camera.position = Config.settings.world_width / 2;

		this.ecs = new ecs.Engine(this);
		this.factory = new Factory(this.ecs);

		this.ecs.addDrawSystem(new DrawSystem());
		this.ecs.addDrawSystem(new RadarDrawSystem(this.s2d));
		this.ecs.addDrawSystem(new DrawDisperseSystem());
		this.ecs.addUpdateSystem(new TimerSystem());
		this.ecs.addUpdateSystem(new StarSystem(s2d));
		var bullet_sys = new BulletSystem();
		this.ecs.addUpdateSystem(bullet_sys);
		this.ecs.addUpdateSystem(new PosSystem());
		this.ecs.addUpdateSystem(new LifeSystem());
		this.ecs.addUpdateSystem(new CollideSystem());
		var laser_sys = new LaserSystem();
		this.ecs.addUpdateSystem(laser_sys);
		this.ecs.addUpdateSystem(new LaserDrawSystem(this.s2d));

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
		fsm_sys.register(new states.npc.human.Rescued());
		fsm_sys.register(new states.npc.human.Die());
		fsm_sys.register(new states.player.Play());
		fsm_sys.register(new states.player.Die());
		fsm_sys.register(new states.game.LevelStart());
		fsm_sys.register(new states.game.Level());
		fsm_sys.register(new states.game.LevelEnd());
		fsm_sys.register(new states.game.GameOver());

		var stree = new StateTree();

		stree.addTransition(Baiter(Materialize), Baiter(Chase));
		stree.addTransition(Baiter(Chase), Baiter(Die));

		stree.addTransition(Lander(Materialize), Lander(Search));
		stree.addTransition(Lander(Search), Lander(Die));
		stree.addTransition(Lander(Search), Lander(Pounce));
		stree.addTransition(Lander(Pounce), Lander(Die));
		stree.addTransition(Lander(Pounce), Lander(Search));
		stree.addTransition(Lander(Pounce), Lander(Kidnap));
		stree.addTransition(Lander(Kidnap), Lander(Search));
		stree.addTransition(Lander(Kidnap), Lander(Die));
		stree.addTransition(Lander(Kidnap), Lander(Mutant));
		stree.addTransition(Lander(Mutant), Lander(Die));

		stree.addTransition(Human(Walk), Human(Die));
		stree.addTransition(Human(Walk), Human(Grabbed));
		stree.addTransition(Human(Grabbed), Human(Die));
		stree.addTransition(Human(Grabbed), Human(Falling));
		stree.addTransition(Human(Falling), Human(Die));
		stree.addTransition(Human(Falling), Human(Walk));
		stree.addTransition(Human(Falling), Human(Rescued));
		stree.addTransition(Human(Rescued), Human(Walk));

		stree.addTransition(Player(Play), Player(Die));
		stree.addTransition(Player(Die), Player(Explode));
		stree.addTransition(Player(Explode), Player(Play));

		stree.addTransition(Game(LevelStart), Game(Level));
		stree.addTransition(Game(Level), Game(LevelEnd));
		stree.addTransition(Game(LevelEnd), Game(GameOver));
		stree.addTransition(Game(LevelEnd), Game(LevelStart));

		fsm_sys.setStateTree(stree);
		this.ecs.addUpdateSystem(fsm_sys);
		this.factory.addGame();

		MessageCentre.register(FireBullet, bullet_sys.fireEvent);
		MessageCentre.register(Killed, this.kill);
		MessageCentre.register(HumanLanded, this.score250);
		MessageCentre.register(HumanSaved, this.score500);
		MessageCentre.register(HumanSaved, this.saveHuman);
		MessageCentre.register(HumanPlaced, this.score500);
		MessageCentre.register(PlayerExplode, this.triggerExplodeParticles);
		MessageCentre.register(FireLaser, laser_sys.fireEvent);
		MessageCentre.register(LevelStart, this.levelStart);
		MessageCentre.register(LevelEnd, this.levelEnd);

		GFX.init(this.s2d);
		this.hud = new Hud(this.s2d);
		this.planet = new Planet(s2d);
		var f = this.factory.addStarsFunc(200);
		this.ecs.schedule(0.1, f);

		// FPS
		var font:h2d.Font = hxd.res.DefaultFont.get();
		this.tf = new h2d.Text(font);
		this.tf.text = "";
		this.tf.textAlign = Center;
		this.tf.setPosition(100, 100);

		s2d.addChild(this.tf);
	}

	public function mountainAt(pos:Int):Int {
		return this.planet.at(pos);
	}

	public function onScreen(pos:Float):Bool {
		return (pos > 0 && pos < s2d.width);
	}

	public override function update(dt:Float) {
	 
		this.planet.draw();
		this.hud.update(dt);
		this.ecs.update(dt);
		this.ecs.draw(dt);
		this.debugUpdate(dt);

		// TODO move to game state
		if (hxd.Key.isPressed(hxd.Key.ESCAPE))
			hxd.System.exit();
	}

	private function debugUpdate(dt:Float) {
		var fps = Std.int(1 / dt);
		this.tf.text = '${fps}  ${Std.int(Camera.position)} ${this.landers_killed}';
	}

	private function triggerExplodeParticles(ev:IEvent) {
		var sw = this.s2d.width;
		var ww = Config.settings.world_width;
		var pos:PosComponent = cast ev.entity.get(Pos);

		var posx = pos.x;
		if (Camera.position < sw && pos.x > ww - sw)
			posx = posx - ww;
		if (Camera.position > ww - sw && pos.x < sw)
			posx = posx + ww;
		GFX.particles.setPosition((20 * pos.direction) + posx - Camera.position, pos.y);
		GFX.particleGroup.enable = true;
		this.ecs.schedule(2, () -> GFX.particleGroup.enable = false);
	}

	private function kill(ev:IEvent) {
		var e = ev.entity;
		var ef:FSMComponent = cast e.get(FSM);
		if (ef.state.match(Player(Play))) {
			if (Config.settings.nodie)
				return;
			ef.next_state = Player(Die);
		} else
			this.killNPC(ev);
	}

	private function killNPC(ev:IEvent) {
		var e = ev.entity;
		var ef:FSMComponent = cast e.get(FSM);
		switch (ef.state) {
			case Baiter(_):
				ef.next_state = Baiter(Die);
			case Human(_):
				ef.next_state = Human(Die);
			case Lander(_):
				{ef.next_state = Lander(Die); this.landers--;};
				this.score+=150;
				this.hud.updateScore(this.score);
			case _:
		}
	}
	private function levelEnd(ev:IEvent) {
		this.freeze = true;
		this.planet.hide();	
	}

	private function levelStart(ev:IEvent) {
		this.planet.show();	
		this.freeze = false;
	}
	
	private function saveHuman(ev:IEvent) {
		var ev:HumanSavedEvent = cast ev;
		var ef:FSMComponent = cast ev.entity.get(FSM);
		ef.next_state = Human(Rescued);
	}

	private function score250(ev:IEvent) {
		var ev:HumanLandedEvent = cast ev;
		var ppc = this.player_pos;
		this.factory.addScore(250, ev.pos.x, ev.pos.y, ppc.dx, 0);
	}

	private function score500(ev:IEvent) {
		var ppc = this.player_pos;
		switch (ev.type) {
			case HumanSaved:
				{
					var ev:HumanSavedEvent = cast ev;
					this.factory.addScore(500, ev.pos.x, ev.pos.y, ppc.dx, 0);
				}
			case HumanPlaced:
				{
					var ev:HumanPlacedEvent = cast ev;
					this.factory.addScore(500, ev.pos.x, ev.pos.y, ppc.dx, 0);
				}
			case _:
				{}
		}
	}
}
