import Enums;

class Config
{
    public static var graphics = {
        lander : {
            png : PNG.Lander,
            frames : 3,
            xpixels : 9,
            ypixels : 8,
            anim_rate : 4
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
            anim_rate : 1
        }
    };
}