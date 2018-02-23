package Actors
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Flag extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="flag1.png")]
		private var Flag1Img:Class;
		
		[Embed (source ="../../lib/images.swf", symbol="flag2.png")]
		private var Flag2Img:Class;
		
		[Embed (source ="../../lib/images.swf", symbol="flag3.png")]
		private var Flag3Img:Class;
		
		[Embed (source ="../../lib/images.swf", symbol="flag4.png")]
		private var Flag4Img:Class;
		
		
		private var flags:Vector.<Bitmap> = new Vector.<Bitmap>(4, true);
		private var currentFlag:int = 0;
		//private var name:String= "flag1";
		private var W:Number = 260;
		private var H:Number = 160;
		
		private var movable:Boolean = false;
		private var animTimer:Timer;
		private var animDirection:Boolean = true;
		
		
		
		
		
		public function Flag() {
			flags[0] = new Flag1Img();
			flags[1] = new Flag2Img();
			flags[2] = new Flag3Img();
			flags[3] = new Flag4Img();
			flags[0].smoothing = true;
			W = flags[0].width;
			H = flags[0].height;
			flags[1].smoothing = true;
			flags[2].smoothing = true;
			flags[3].smoothing = true;
			addChild(flags[0]);
			animTimer = new Timer(200);
			animTimer.addEventListener(TimerEvent.TIMER, timerAnimationHandler);
			animTimer.start();
		}
		
		private function timerAnimationHandler(e:TimerEvent):void {
			
			var nextFlag:int;
			if (animDirection) {
				nextFlag = currentFlag + 1;
				if (nextFlag == 4) {
					nextFlag = 2;
					animDirection = false;
				}
			}else {
				nextFlag = currentFlag - 1;
				if (nextFlag == -1) {
					nextFlag = 1;
					animDirection = true;
				}
			}
			
			removeChild(flags[currentFlag]);
			addChild(flags[nextFlag]);
			currentFlag = nextFlag;
		}
		
	
		public function animStop():void {
			animTimer.stop();
		}
		
		public function animStart():void {
			animTimer.start();
		}
		
		public function destroy():void {
			animTimer.stop();
			animTimer.removeEventListener(TimerEvent.TIMER, timerAnimationHandler);
			animTimer = null;
			removeChild(flags[currentFlag]);
			for (var i:uint = 0; i < flags.length; i++) {
				flags[i] = null;
			}
			flags = null;
			
		}
		
		
	}
	
}