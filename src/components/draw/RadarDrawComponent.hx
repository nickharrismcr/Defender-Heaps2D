package components.draw;


import h2d.Bitmap;
import ecs.IComponent;

// @:build(macros.ComponentEnumMacro.build()) 

class RadarDrawComponent implements IComponent
{
    public var type:ComponentType = RadarDraw;
    public var udrawable:h2d.Bitmap;
    public var ldrawable:h2d.Bitmap;
    public var ucolors:Array<h3d.Vector>;
    public var lcolors:Array<h3d.Vector>;
    public var idx:Int;
    public var t:Float;
 
    public function new(tile:h2d.Tile,type:PNG)
    {
        this.udrawable=new Bitmap(tile);
        this.ldrawable=new Bitmap(tile);
        var cols=GFX.getRadarColors(type);
        this.ucolors=cols[0];
        this.lcolors=cols[1];
        this.idx=0;
        this.t=0;
    }    
}