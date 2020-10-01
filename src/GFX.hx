import h2d.Anim;
import h2d.Tile;

class GFX
{
    var anim_tiles:Map<String,Array<h2d.Tile>>;
    var explode_tiles:Map<String,Array<h2d.Tile>>;

    public function new()
    {
        hxd.Res.initEmbed();
        this.anim_tiles = new Map<String,Array<h2d.Tile>>();
        this.explode_tiles= new Map<String,Array<h2d.Tile>>();
    }

    public function load(s:String,frames:Int, xpixels:Int, ypixels:Int )
    {
        var tex=this.toTexture(s);
        var tile=h2d.Tile.fromTexture(tex);
        var arr=tile.split(frames,false);
        this.anim_tiles[s]=arr;
        var frame1 = arr[0];

        
    }

    public function get(s:String, speed:Int)
    {
        if ( !this.anim_tiles.exists(s) ) throw new haxe.Exception('resource $s not found');
        return new Anim(this.anim_tiles[s],speed);
    }

    // load texture from resources, replacing magenta with alpha=0
    private function toTexture(s:String)
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