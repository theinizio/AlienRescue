package Actors
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Tur extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="Tur.png")]
		private var TurImg:Class;
		private var explosion:Bitmap;
		
		
		
		private var screen:Bitmap;
		//private var name:String= "flag1";
		private var W:Number = 88;
		private var H:Number = 93;
		
		private var framesCount:uint = 19;
		private var animTimer:Timer;
		
		
		
		
		
		
		
		
		
		
		
		
		
		public function Tur() {
			
			explosion = new TurImg();
			explosion.smoothing = true;
			W = explosion.width/framesCount;
			H = explosion.height;
			screen = new Bitmap();
			screen.smoothing = true;
			screen.bitmapData = new BitmapData(W, H, true, 0);
			
			
			animTimer = new Timer(38, framesCount);
			animTimer.addEventListener(TimerEvent.TIMER, makeBang);
			animTimer.addEventListener(TimerEvent.TIMER_COMPLETE, animFinished);
			addEventListener(MouseEvent.DOUBLE_CLICK, animStop);
			
		}
		private function animFinished(e:TimerEvent):void {
			removeChild(screen);
		}
		private function makeBang(e:TimerEvent):void {
			screen.bitmapData.fillRect(new Rectangle(0, 0, W, H), 0);
			screen.bitmapData.copyPixels(explosion.bitmapData, new Rectangle((animTimer.currentCount - 1) * W, 0, W, H), new Point());
			
		}
		
		public function animStop(e:MouseEvent=null):void {
			if (getChildByName("screen")) removeChild(screen);
			animTimer.stop();
			
		}
		
		public function animStart():void {
			addChild(screen);
			animTimer.reset();
			animTimer.start();
		}
		
		
		
	}
	
}