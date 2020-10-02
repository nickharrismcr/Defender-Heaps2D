import h2d.Anim;
import h2d.Tile;
import Enums;
import Config;

class DisperseTiles
{
    public var xpixels:Int;
    public var ypixels:Int;
    public var tiles:Array<Array<h2d.Tile>>;
    public var pixsize:Int;

    public function new(xpixels:Int,ypixels:Int,tile:h2d.Tile)
    {
        this.xpixels=xpixels;
        this.ypixels=ypixels;
        this.pixsize=Std.int(tile.width/xpixels);
        this.tiles=tile.grid(this.pixsize);
    }

    public function getBitmaps():Array<Array<h2d.Bitmap>>
    {
        var ret = new Array<Array<h2d.Bitmap>>();
        for ( x in 0...this.xpixels ) {
            ret[x]=[];
            for ( y in 0...this.ypixels ) {
                ret[x][y] = new h2d.Bitmap(this.tiles[x][y]);
            }
        }
        return ret;
    }
}

class GFX
{
    private static var anim_tiles:Map<String,Array<h2d.Tile>>;
    private static var anim_rates:Map<String,Int>;
    private static var disperse_tiles:Map<String,DisperseTiles>;

    public static function init()
    {
        hxd.Res.initEmbed();
        GFX.anim_tiles = new Map<String,Array<h2d.Tile>>();
        GFX.disperse_tiles= new Map<String,DisperseTiles>();
        GFX.anim_rates = new Map<String,Int>();

        for ( k in Reflect.fields(Config.graphics))
        {
            var v = Reflect.getProperty(Config.graphics,k);
            GFX.load(v.png , v.frames, v.xpixels, v.ypixels, v.speed );
        }
    }

    public static function load(png:PNG,frames:Int, xpixels:Int, ypixels:Int, speed:Int )
    {
        var s = Std.string(png);
        var tex=GFX.toTexture(s);
        var tile=h2d.Tile.fromTexture(tex);
        var arr=tile.split(frames,false);
        GFX.anim_tiles[s]=arr;
        var frame1 = arr[0];
        GFX.disperse_tiles[s]=new DisperseTiles(xpixels,ypixels,frame1);
        GFX.anim_rates[s] = speed;
        
    }

    public static function getAnim(png:PNG):h2d.Anim
    {
        var s=Std.string(png);
        if ( !GFX.anim_tiles.exists(s) ) throw new haxe.Exception('resource $s not found');
        return new Anim(GFX.anim_tiles[s],GFX.anim_rates[s]);
    }

    public static function getDisperse(png:PNG)
    {
        var s=Std.string(png);
        if ( !GFX.disperse_tiles.exists(s) ) throw new haxe.Exception('resource $s not found');
        return GFX.disperse_tiles[s]; 
    }

    // load texture from resources, replacing magenta with alpha=0
    private static function toTexture(s:String)
    {
        var pix=hxd.Res.loader.load(s).toImage().getPixels(RGBA);
        
        for ( x in 0...pix.width){
            for ( y in 0...pix.height) {
                var col= pix.getPixel(x,y);
                if ( col == -65281 ){
                    pix.setPixel(x,y,0x00000000 );
                }
            }
        }
        return h3d.mat.Texture.fromPixels(pix);
    }
}