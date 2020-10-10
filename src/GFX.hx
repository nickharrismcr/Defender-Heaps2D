import h3d.Vector;
import h2d.Anim;
import h2d.Tile;
import h2d.Particles.ParticleGroup;

class DisperseTiles {
	public var xpixels:Int;
	public var ypixels:Int;
	public var tiles:Array<Array<h2d.Tile>>;
	public var pixsize:Int;

	public function new(xpixels:Int, ypixels:Int, tile:h2d.Tile) {
		this.xpixels = xpixels;
		this.ypixels = ypixels;
		this.pixsize = Std.int(tile.width / xpixels);
		this.tiles = tile.grid(this.pixsize);
	}

	public function getBitmaps():Array<Array<h2d.Bitmap>> {
		var ret = new Array<Array<h2d.Bitmap>>();
		for (x in 0...this.xpixels) {
			ret[x] = [];
			for (y in 0...this.ypixels) {
				ret[x][y] = new h2d.Bitmap(this.tiles[x][y]);
			}
		}
		return ret;
	}
}

class GFX {
	private static var anim_tiles:Map<String, Array<h2d.Tile>>;
	private static var anim_rates:Map<String, Int>;
	private static var disperse_tiles:Map<String, DisperseTiles>;
	public static var particles:h2d.Particles;
	public static var particleGroup:h2d.ParticleGroup;
	private static var fontTiles:Array<h2d.Tile>;
	private static var fontChars:String;

	public static function init(s2d:h2d.Scene) {
		hxd.Res.initEmbed();
		GFX.anim_tiles = new Map<String, Array<h2d.Tile>>();
		GFX.disperse_tiles = new Map<String, DisperseTiles>();
		GFX.anim_rates = new Map<String, Int>();

		for (k in Reflect.fields(Config.graphics)) {
			var v = Reflect.getProperty(Config.graphics, k);
			GFX.load(v.png, v.frames, v.xpixels, v.ypixels, v.anim_rate);
		}

		GFX.particles = new h2d.Particles(s2d);
		GFX.particleGroup = new ParticleGroup(GFX.particles);
		GFX.particleGroup.emitLoop = false;
		GFX.particleGroup.nparts = 500;
		GFX.particleGroup.emitMode = Point;
		GFX.particleGroup.life = 2;
		GFX.particleGroup.size = 0.6;
		GFX.particleGroup.sizeIncr = -0.1;
		GFX.particleGroup.speed = 800;
		GFX.particleGroup.speedIncr = -0.8;
		GFX.particleGroup.speedRand = 0.8;
		GFX.particleGroup.emitDelay = 0;
		GFX.particleGroup.emitSync = 1;
		GFX.particleGroup.fadeIn = 0;
		GFX.particleGroup.fadeOut = 1;
		GFX.particleGroup.gravity = 200;
		GFX.particleGroup.gravityAngle = 0.01;
		var gpix = hxd.Res.loader.load("gradient.png").toImage().getPixels(RGBA);
		GFX.particleGroup.colorGradient = h3d.mat.Texture.fromPixels(gpix);
		GFX.particles.setPosition(300, 300);
		GFX.particleGroup.enable = false;
		GFX.particles.addGroup(GFX.particleGroup);

		GFX.loadfont();
		GFX.fontChars = "0123456789:?ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	}

	public static function load(png:PNG, frames:Int, xpixels:Int, ypixels:Int, speed:Int) {
		var s = Std.string(png);
		var tex = GFX.toTexture(s);
		var tile = h2d.Tile.fromTexture(tex);
		var arr = tile.split(frames, false);
		GFX.anim_tiles[s] = arr;
		var frame1 = arr[0];
		GFX.disperse_tiles[s] = new DisperseTiles(xpixels, ypixels, frame1);
		GFX.anim_rates[s] = speed;
	}

	public static function loadfont() {
		var fontTex = GFX.toTexture('font.png');
		GFX.fontTiles = h2d.Tile.fromTexture(fontTex).gridFlatten(28);
	}

	public static function getFontBitmap(char:String):h2d.Bitmap {
		var index = GFX.fontChars.indexOf(char);
		return new h2d.Bitmap(GFX.fontTiles[index]);
	}

	public static function getRadarColors(g:PNG):Array<Array<Vector>> {
		switch (g) {
			case Baiter:
				return [[new Vector(0, 0.7, 0)], [new Vector(0, 0, 0)]];
			case Lander:
				return [[new Vector(0.5, 0.5, 0)], [new Vector(0, 0.5, 0)]];
			case Mutant:
				return [
					[
						new Vector(1, 0, 0),
						new Vector(0, 1, 0),
						new Vector(0, 0, 1),
						new Vector(1, 1, 0)
					],
					[
						new Vector(1, 0, 0),
						new Vector(0, 1, 0),
						new Vector(0, 0, 1),
						new Vector(1, 1, 0)
					]
				];
			case Human:
				return [[new Vector(1, 0.0, 1)], [new Vector(0.4, 0.0, 0.4)]];
			case Player:
				return [[new Vector(1, 1, 1)], [new Vector(1, 1, 1)]];
			case _:
				return [[], []];
		}
	}

	public static function getAnim(png:PNG):h2d.Anim {
		var s = Std.string(png);
		if (!GFX.anim_tiles.exists(s))
			throw new haxe.Exception('resource $s not found');
		return new Anim(GFX.anim_tiles[s], GFX.anim_rates[s]);
	}

	public static function getDisperse(png:PNG) {
		var s = Std.string(png);
		if (!GFX.disperse_tiles.exists(s))
			throw new haxe.Exception('resource $s not found');
		return GFX.disperse_tiles[s];
	}

	// load texture from resources, replacing magenta with alpha=0
	private static function toTexture(s:String) {
		var pix = hxd.Res.loader.load(s).toImage().getPixels(RGBA);

		for (x in 0...pix.width) {
			for (y in 0...pix.height) {
				var col = pix.getPixel(x, y);
				if (col == -65281) {
					pix.setPixel(x, y, 0x00000000);
				}
			}
		}
		return h3d.mat.Texture.fromPixels(pix);
	}
}
