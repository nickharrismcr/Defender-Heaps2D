import Camera;
import h2d.Scene;

class Planet {
	var mountain:Array<Int>;
	var scene:h2d.Scene;
	var graphics:h2d.Graphics;
	var visible:Bool = true;
	var colors:Array<Int>;
	var dimcolors:Array<Int>;

	public function new(scene:Scene) {
		this.scene = scene;
		this.graphics = new h2d.Graphics(scene);
		this.mountain = new Array<Int>();
		var h:Int = 20;
		var maxh:Int = Std.int(scene.height / 4);
		var dh:Int = 4;
		this.colors = [ Utils.red.toColor(), Utils.orange.toColor(), Utils.green.toColor(), Utils.blue.toColor() ];

		var i = 0;
		var x = 0;
		var step = 4;
		var w = Config.settings.world_width;

		while (true) {
			x += step;
			i++;
			if (x <= w) {
				this.mountain.push(h);
				h += dh;
				if (h < 20 || h > maxh || Std.random(10) == 1) {
					dh = -dh;
				}
			} else {
				if (h <= this.mountain[i - this.mountain.length])
					break;
				h -= 4;
				this.mountain[i - this.mountain.length] = h;
			}
		}
	}

	public function hide() {
		this.visible = false;
	}

	public function show() {
		this.visible = true;
	}

	public function at(pos:Int) {
		return this.mountain[Std.int(pos / 4)];
	}

	public function draw() {
		var prevcol:Int = -1;
		this.graphics.clear();
		if (!this.visible)
			return;
		var x = 0;
		var i = Std.int(Camera.position / 4);
		var step = 4;
		var ww = Config.settings.world_width;
		
		
		
		while (x < this.scene.width) {

			var col = Std.int(4*(Camera.position+x)/ww);
			if ( col != prevcol ){
				this.graphics.endFill();
				this.graphics.beginFill(this.colors[col%4]);
				prevcol = col;
			}
			i++;
			if (i >= this.mountain.length)
				i -= this.mountain.length;
			if (i < 0)
				i += this.mountain.length;
			x += step;
			this.graphics.drawRect(x, this.scene.height - this.mountain[i], 4, 4);
		}
		this.graphics.endFill();


		var sw = this.scene.width;
		var sh = this.scene.height;
		var rxs = sw * 0.25;
		var rxe = sw * 0.75;
		var rw = rxe - rxs;
		var rye = Config.settings.play_area_start - 50;
		var ww = Config.settings.world_width;
		var rsw = rw * (sw / ww);

		i = Std.int(Camera.position - (ww / 2) + sw / 2);
		x = 0;
		prevcol=-1;

		while (x < ww) {
			x += 40;
			i += 40;
			if (i < 0)
				i += ww;
			if (i > ww)
				i -= ww;

			var col = Std.int(4*i/ww);
			if ( col != prevcol ){
				this.graphics.endFill();
				this.graphics.beginFill(this.colors[col%4]);
				prevcol = col;
			}
			this.graphics.drawRect(rxs + rw * (x / ww), rye - (this.at(i) * (rye / sh)), 2, 2);
		}

		this.graphics.endFill();
	}
}
