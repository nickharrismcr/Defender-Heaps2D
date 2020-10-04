package components.draw;

import h2d.Bitmap;
import ecs.IComponent;
import GFX;

 
 

////@:build(macros.ComponentEnumMacro.build())   
class DrawDisperseComponent implements IComponent
{
    public var type = DrawDisperse;
    public var tiles:DisperseTiles;
    public var drawables:Array<Array<h2d.Bitmap>>;
    public var disperse:Float;

    public function new(tiles:DisperseTiles)
    {
        this.tiles=tiles;
        this.drawables=tiles.getBitmaps();
        this.disperse=1;
    }    
}