package{
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	public class ProgressBar extends Sprite {
		  
		
		
		[Embed (source = "loader/bg_loader.png")]
		private var Bg:Class;
		
		[Embed (source = "loader/progress_barr_glass.png")]
		private var Glass:Class;
		  
		[Embed (source = "loader/white_stripes_angled.png")]
		private var Stripes:Class;
		  
		[Embed (source = "loader/shadow.png")]
		private var Shadow:Class;
		  
		
		private var bg:Bitmap;
		private var output:Bitmap;
		private var min:int =   0;
		private var max:int = 100;
		private var curPos:int = 0;
		
		private var W:int = 307;
		private var H:uint = 20;
		
		private var firstStripe:Boolean = true;
		private var stripes:Bitmap;
		private var stripes2:Bitmap;
		private var animW:int;
		private var cache:BitmapData;
		private var draw:Bitmap = new Bitmap();
		private var screen:Sprite=new Sprite();
		
		private var shadow:Bitmap = new Shadow();
		
		
		
		public function setProgress(progress:int):void {
			if (min <= progress <= max) {
				progress = Math.round(W*progress/100);
				
				curPos = progress;	
			}
		}
		  
		  
		  
		  
		
	
		public function ProgressBar() {
			// constructor code
			
			
			shadow.smoothing = true;
			draw.smoothing = true;
			cache = new BitmapData(W, H, true, 0);
			
			var glass:Bitmap = new Glass();
			glass.smoothing = true;
			screen.addChild(glass);
			
			stripes = new Stripes();
			stripes.smoothing = true;
			stripes2 = new Stripes();
			stripes2.smoothing = true;
			screen.addChild(stripes);
			screen.addChild(stripes2);
			animW = (stripes.width - glass.width);
			stripes.x -= animW;
			stripes2.x -= (stripes2.width - stripes.x);
			
			screen.addChild(shadow);
			
			draw.bitmapData = cache;
			//addChild(draw);
			addEventListener(Event.ENTER_FRAME, anim);	
			
			output = new Bitmap();
			output.smoothing = true;
			output.bitmapData = new BitmapData(W, H, true, 0x0);
			output.x = 8;
			output.y = 7;
		
			bg = new Bg();
			bg.smoothing = true;
			addChild(bg);
			addChild(output);
		
	
		}
		
		
		
		private function anim(e:Event):void {
			cache.draw(screen);
			if ((stripes2.x == (stripes2.width -animW+5)) ) stripes2.x -= 694*2+1;
			if ((stripes.x == (stripes.width-animW+5)) ) stripes.x -= 694*2+1;
			stripes.x += 1;
			stripes2.x += 1;
			
			output.bitmapData.fillRect(new Rectangle(0, 0, W, H), 0x0);
			output.bitmapData.draw(screen, null, null, null, new Rectangle(0, 0, curPos, H),false);
		}
	}
	

}