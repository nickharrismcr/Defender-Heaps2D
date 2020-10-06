 
import Camera;
 
import h2d.Scene;

class Planet
{
    var mountain:Array<Int>; 
    var scene:h2d.Scene;
    var graphics:h2d.Graphics;

    public function new(scene:Scene)
    {
        this.scene=scene;
        this.graphics = new h2d.Graphics(scene);
        this.mountain = new Array<Int>();
        var h:Int=20;
        var maxh:Int=Std.int(scene.height/4);
        var dh:Int=4;

        var i = 0;
        var x = 0;
        var step = 4;
        var w=Config.settings.world_width;

        while ( true ) {
            x+=step;
            i++;
            if ( x <= w ){
                this.mountain.push(h);
                h+=dh;
                if ( h < 20 || h > maxh || Std.random(10) == 1 ){
                    dh=-dh;
                }
            } else {
                if ( h <= this.mountain[i-this.mountain.length] ) break;
                h-=4;
                this.mountain[i-this.mountain.length] = h;
               
            }
        }
       
    }

    public function at(pos:Int)
    {
        return this.mountain[Std.int(pos/4)];
    }

    public function draw(){

        this.graphics.clear();
        this.graphics.beginFill(0x994400);
        var x = 0;
        var i = Std.int(Camera.position/4);
        var step = 4;
        var ww = Config.settings.world_width;

        while ( x < this.scene.width ){

            i++;
            if ( i >= this.mountain.length ) i -= this.mountain.length; 
            if ( i < 0 ) i += this.mountain.length;    
            x+=step;
            this.graphics.drawRect(x,this.scene.height-this.mountain[i],4,4);
        }

       

        var sw = this.scene.width;
		var sh = this.scene.height;
		var rxs = sw*0.25;
		var rxe = sw*0.75;
		var rw = rxe-rxs;
		var rye = Config.settings.play_area_start-50;
		var ww = Config.settings.world_width;
		var rsw = rw * (sw/ww);
        
        i = Std.int(Camera.position - (ww/2) + sw/2);
        x = 0;
         
        while ( x < ww ) {
            x+=30;
            i+=30;
            if ( i < 0) i += ww;
            if ( i > ww ) i -= ww;
            this.graphics.drawRect(rxs+rw*(x/ww), rye- (this.at(i)*(rye/sh)),2,2);
        }
           
        this.graphics.endFill();



    }



}