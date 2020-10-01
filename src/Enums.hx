
enum EventType
{
    TestEventType;
}

enum ComponentType 
{
    Pos;
    Draw;
    FSM;
    Timer;
}

enum SystemType 
{
    DrawSystem;
    FSMSystem;
    TimerSystem;
}

enum States 
{
    TestMove;
    TestStop;
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


