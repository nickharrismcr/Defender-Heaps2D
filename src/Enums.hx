

enum EventType
{
    LevelStart;
    LevelEnd;
    FireBullet;
    FireLaser;
    Killed;
    HumanLanded;
    Kidnap;
    HumanSaved;
    HumanPlaced;
    PlayerExplode;
}

enum ComponentType 
{
    Pos;
    Draw;
    RadarDraw;
    DrawDisperse;
    FSM;
    Timer;
    Star;
    Bullet;
    Deadly;
    Collide;
    Human;
    HumanFinder;
    Life;
    Player;
    Laser;
    Shootable;
}

enum BulletType
{
    Bullet;
    Bomb;
}

enum SystemType 
{
    DrawSystem;
    DrawDisperseSystem;
    RadarDrawSystem;
    FSMSystem;
    TimerSystem;
    StarSystem;
    BulletSystem;
    CollideSystem;
    PosSystem;
    LifeSystem;
    LaserSystem;
    LaserDrawSystem;
}

enum States 
{
    Game(s:GameStates);
    Player(s:PlayerStates);
    Human(s:HumanStates);
    Lander(s:LanderStates);
    Bomber(s:BomberStates);
    Baiter(s:BaiterStates);
    Pod(s:PodStates);
    Swarmer(s:SwarmerStates);
    Bullet(s:BulletStates);
}

enum GameStates
{
    LevelStart;
    Level;
    LevelEnd;
    GameOver;
}

enum PlayerStates
{
    Play;
    Hyperspace;
    Die;
    Explode;
    Materialize;
}

enum HumanStates
{
    Walk;
    Grabbed;
    Falling;
    Rescued;
    Die;
}

enum LanderStates
{
    Wait;
    Materialize;
    Search;
    Pounce;
    Kidnap;
    Mutant;
    Die;
}

enum BomberStates
{
    Move;
    Die;
}

enum BaiterStates
{
    Wait;
    Materialize;
    Chase;
    Die;
}

enum PodStates
{
    Move;
    Die;
}

enum SwarmerStates
{
    Chase;
    Die;
}

enum BulletStates
{
    Move;
    Die;
}

enum abstract PNG(String)
{
    var Lander = "lander.png";
    var Mutant = "mutant.png";
    var Baiter = "baiter.png";
    var Bomber = "bomber.png";
    var Swarmer = "swarmer.png";
    var Pod = "pod.png";
    var Human = "human.png";
    var Bullet = "bullet.png";
    var Score250 = "250.png";
    var Score500 = "500.png";
    var Player = "ship.png";
    var PlayerDie = "shipd.png";
}
