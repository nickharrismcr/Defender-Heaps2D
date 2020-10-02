
enum EventType
{
    FireBullet;
}

enum ComponentType 
{
    Pos;
    Draw;
    DrawDisperse;
    FSM;
    Timer;
    Star;
    Bullet;
    Deadly;
    Shootable;
    Collide;
}

enum SystemType 
{
    DrawSystem;
    DrawDisperseSystem;
    FSMSystem;
    TimerSystem;
    StarSystem;
    BulletSystem;
    CollideSystem;
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
    Play;
    LevelEnd;
    GameOver;
}

enum PlayerStates
{
    Play;
    Hyperspace;
    Die;
    Explode;
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
    Find;
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
    var Baiter = "baiter.png";
    var Bomber = "bomber.png";
    var Swarmer = "swarmer.png";
    var Pod = "pod.png";
    var Human = "human.png";
    var Bullet = "bullet.png";
}
