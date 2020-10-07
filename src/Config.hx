import hxd.Key;

class Config
{
    public static var settings = {
        bullet_time:2,
        world_width:12000,
        grab_speed:80,
        play_area_start:200
    };

    public static var keys = {
        thrust : hxd.Key.ENTER,
        reverse: hxd.Key.SPACE,
        up     : hxd.Key.Q,
        down   : hxd.Key.A,
        fire   : hxd.Key.QWERTY_BRACKET_RIGHT
    };

    public static var graphics = {
        lander : {
            png : PNG.Lander,
            frames : 3,
            xpixels : 9,
            ypixels : 8,
            anim_rate : 4
        },
        mutant : {
            png : PNG.Mutant,
            frames : 6,
            xpixels : 9,
            ypixels : 8,
            anim_rate : 10
        },
        baiter : {
            png : PNG.Baiter,
            frames : 2,
            xpixels : 11,
            ypixels : 4,
            anim_rate : 4,
        },
        bullet : {
            png : PNG.Bullet,
            frames : 2,
            xpixels : 3,
            ypixels : 3,
            anim_rate : 8
        },
        human : {
            png : PNG.Human,
            frames : 1,
            xpixels : 3,
            ypixels : 8,
            anim_rate : 1
        },
        score250 : {
            png : PNG.Score250,
            frames : 3,
            xpixels : 11,
            ypixels : 3,
            anim_rate : 8
        },
        score500 : {
            png : PNG.Score500,
            frames : 3,
            xpixels : 11,
            ypixels : 3,
            anim_rate : 8
        },
        player : {
            png : PNG.Player,
            frames : 5,
            xpixels : 15,
            ypixels : 6,
            anim_rate : 4
        },
        playerDie : {
            png : PNG.PlayerDie,
            frames : 2,
            xpixels : 15,
            ypixels : 6,
            anim_rate : 20
        }
    };
}