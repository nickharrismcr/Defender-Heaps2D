import haxe.iterators.StringKeyValueIteratorUnicode;

class Hud {
	var gfx:h2d.Graphics;
    var s2d:h2d.Scene;
    var score:String;
    var scoreBMPs:Array<h2d.Bitmap>;
    var scoreCol:h3d.Vector;
    var cycle:(c:h3d.Vector,dt:Float)->Void; 
    
	public function new(s2d:h2d.Scene) {
		this.s2d = s2d;
        this.gfx = new h2d.Graphics(s2d);
        this.scoreBMPs = new Array<h2d.Bitmap>();
        this.score = ".......";
        this.updateScore("0000000");
        this.scoreCol = new h3d.Vector(1,1,1,1);
        this.cycle = Utils.getColorCycleGenerator(0.5);
    }
    
    public function updateScore(newScore:String){
        var i=0;
        for ( bmp in this.scoreBMPs) {
            this.s2d.removeChild(bmp);
        }
        for ( i in 0...newScore.length ){
          
            var bmp = GFX.getFontBitmap(newScore.charAt(i));
            bmp.setPosition(i*30,30);
            this.s2d.addChild(bmp);
            this.scoreBMPs[i]=bmp; 
        }
    }


	public function update(dt:Float) {
		var sw = s2d.width;
		var sh = s2d.height;
		var rxs = sw * 0.25;
		var rxe = sw * 0.75;
		var rw = rxe - rxs;
		var rye = Config.settings.play_area_start - 50;
		var ww = Config.settings.world_width;
		var rsw = rw * (sw / ww);

		this.gfx.clear();
		this.gfx.beginFill(0x000099);
		this.gfx.drawRect(0, rye + 20, sw, 3);
		this.gfx.drawRect(rxs - 20, 0, 3, rye + 20);
		this.gfx.drawRect(rxe + 20, 0, 3, rye + 20);
		this.gfx.endFill();
		this.gfx.beginFill(0xffffff);
		this.gfx.drawRect((sw / 2) - (rsw / 2), 0, rsw, 3);
		this.gfx.drawRect((sw / 2) - (rsw / 2), rye + 17, rsw, 3);
        this.gfx.endFill();
        
        this.scoreCol.r = Math.random();
        this.scoreCol.g = Math.random();
        this.scoreCol.b = Math.random();
        this.cycle(this.scoreCol,dt);
        for ( bmp in this.scoreBMPs) {
            bmp.color = scoreCol;
        }
	}
}
