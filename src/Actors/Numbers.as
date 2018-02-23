package Actors
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Numbers extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="Numbers.png")]
		private var NumImg:Class;
		private var explosion:Bitmap;
		
		
		
		private var screen:Bitmap;
		
		private var W:Number = 88;
		private var H:Number = 93;
		
		private var framesCount:uint = 10;
		
		private var toShow:uint = 0;
		
		
		
		
		
		
		
		
		
		
		
		
		public function Numbers(n:uint=0) {
			if((n>=0)&&(n<10))toShow = n;
			explosion = new NumImg();
			explosion.smoothing = true;
			W = explosion.width/framesCount;
			H = explosion.height;
			screen = new Bitmap();
			screen.smoothing = true;
			screen.bitmapData = new BitmapData(W, H, true, 0);
			showNumber(n);
			addChild(screen);
			
			y = 60;
		}
		
		public function showNumber(n:uint=0):void {
			if((n>=0)&&(n<10))toShow = n;
			screen.bitmapData.fillRect(new Rectangle(0, 0, W, H), 0);
			screen.bitmapData.copyPixels(explosion.bitmapData, new Rectangle(toShow * W, 0, W, H), new Point());
			
		}
		
		
		
		
		
	}
	
}