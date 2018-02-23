package Actors
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class World2Clouds extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="world2clouds.png")]
		private var World2CloudImg:Class;
		private var cloud1: Bitmap;
		private var cloud2: Bitmap;
		

		private var W:Number = 1024;
		public var H:Number = 311;
		private var speed:int = 6;
		private var screen:Sprite;
		private var output:Bitmap;
		private var animTimer:Timer;
		private var animDirection:Boolean = true;
		
		
		
		
		
		
		public function World2Clouds() {
			cloud1 = new World2CloudImg();
			cloud1.smoothing = true;
			cloud2 = new World2CloudImg();
			cloud2.smoothing = true;
			screen = new Sprite();
			output = new Bitmap();
			output.smoothing = true;
			W = cloud1.width;
			H = cloud1.height;
			output.bitmapData = new BitmapData(W, H, true, 0);
			addChild(output);
			cloud2.x -= W;
			screen.addChild(cloud1);
			screen.addChild(cloud2);
			animTimer = new Timer(400);
			animTimer.addEventListener(TimerEvent.TIMER, timerAnimationHandler);
			animTimer.start();
		}
		
		private function timerAnimationHandler(e:TimerEvent):void {
			cloud2.x += speed;
			cloud1.x += speed;
			if (cloud1.x >= W) cloud1.x -= W * 2;
			if (cloud2.x >= W) cloud2.x -= W * 2;
			output.bitmapData.fillRect(new Rectangle(0, 0, W, H), 0x0);
			output.bitmapData.draw(screen, null, null, null, new Rectangle(0, 0, W, H),false);
		}
		
		
		public function destroy():void {
			animTimer.stop();
			animTimer.removeEventListener(TimerEvent.TIMER, timerAnimationHandler);
			animTimer = null;
			removeChild(output);
			screen.removeChild(cloud1);
			screen.removeChild(cloud2);
			output.bitmapData = null;
			output = null;
			screen = null;
			cloud1 = null;
			cloud2 = null;
		}
		
		
		
		
		
		
		public function animStop():void {
			animTimer.stop();
		}
		
		public function animStart():void {
			animTimer.start();
		}
		
		
		
	}
	
}