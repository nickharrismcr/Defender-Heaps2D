import hxd.Key;

class Config {
	public static var settings = {
		world_width: 12000,
		play_area_start: 200,
		nodie: true
	};

	public static var levels = {
		level: 0,
		humans: 20,
		landers: [18, 21, 24, 27, 30, 30, 30, 30, 30],
		baiters: [1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4],
		pods: [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 4, 4],
		bombers: [0, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7],
		bullet_time: [3, 3, 3, 2, 2, 2, 1, 1, 1],
		grab_speed: [60, 70, 80, 90, 100, 110, 120, 130, 140],
		teleport_dist: [ 2000, 2000, 1500, 1500, 1000, 1000, 1000 ]
	}

	public static var keys = {
		thrust: hxd.Key.ENTER,
		reverse: hxd.Key.SPACE,
		up: hxd.Key.Q,
		down: hxd.Key.A,
		fire: hxd.Key.QWERTY_BRACKET_RIGHT
	};

	public static var graphics = {
		lander: {
			png: PNG.Lander,
			frames: 3,
			xpixels: 9,
			ypixels: 8,
			anim_rate: 4
		},
		mutant: {
			png: PNG.Mutant,
			frames: 6,
			xpixels: 9,
			ypixels: 8,
			anim_rate: 10
		},
		baiter: {
			png: PNG.Baiter,
			frames: 2,
			xpixels: 11,
			ypixels: 4,
			anim_rate: 4,
		},
		bullet: {
			png: PNG.Bullet,
			frames: 2,
			xpixels: 3,
			ypixels: 3,
			anim_rate: 8
		},
		human: {
			png: PNG.Human,
			frames: 1,
			xpixels: 3,
			ypixels: 8,
			anim_rate: 1
		},
		score250: {
			png: PNG.Score250,
			frames: 3,
			xpixels: 11,
			ypixels: 3,
			anim_rate: 8
		},
		score500: {
			png: PNG.Score500,
			frames: 3,
			xpixels: 11,
			ypixels: 3,
			anim_rate: 8
		},
		player: {
			png: PNG.Player,
			frames: 5,
			xpixels: 15,
			ypixels: 6,
			anim_rate: 4
		},
		playerDie: {
			png: PNG.PlayerDie,
			frames: 2,
			xpixels: 15,
			ypixels: 6,
			anim_rate: 20
		}
	};

	public static function getBulletTime()
	{
		return Config.levels.bullet_time[Config.levels.level];
	}
	public static function getLanders()
	{
		return Config.levels.landers[Config.levels.level];
	}
	public static function getGrabSpeed()
	{
		return Config.levels.grab_speed[Config.levels.level];
	}
	public static function getTeleportDist()
	{
		return Config.levels.teleport_dist[Config.levels.level];
	}
}
