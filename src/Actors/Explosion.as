package Actors
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	import flash.media.*;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Explosion extends Sprite
	{
		
		public static const EXPLODED:String = "exploded";
		
		[Embed(source='../../lib/images.swf', symbol='explosion.png')]
		private var ExplImg:Class;
		private var explosion:Bitmap;
		
		private var boom:Boom ;//= new Boom();
		private var volume:Number = 0.136145;
		private var screen:Bitmap;
		//private var name:String= "flag1";
		private var W:Number = 160;
		private var H:Number = 160;
		private var speed:int = 30;
		
		private var animTimer:Timer;
		
		public var soundsAllowed:Boolean = true;
		public function startSounds():void {
			soundsAllowed = true;
		}
		
		public function stopSounds():void {
			if (sndChannel) sndChannel.stop();
			soundsAllowed = false;
		}
		
		//[Embed(source="../sounds/Explosion1.mp3")]
		[Embed(source='../../lib/images.swf', symbol='BangSound')]
        [Bindable]
        public var ExplosionSndCls:Class;
            
        public var snd:Sound = new ExplosionSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playLightSound():void {
			if (soundsAllowed) {
				//if(sndChannel){
					sndChannel = snd.play();
					//sndChannel.soundTransform.volume = volume;
				//}
			}
        }   
            
        public function stopLightSound():void {
            if (sndChannel)
				sndChannel.stop();
        }
		
		
		
		
		
		
		
		
		
		
		
		
		public function Explosion() {
			
			/*
			explosion = new ExplImg();
			explosion.smoothing = true;
			W = explosion.width/27;
			H = explosion.height;
			
			screen = new Bitmap();
			screen.smoothing = true;
			screen.bitmapData = new BitmapData(W, H, true, 0);
			
			*/
			animTimer = new Timer(500, 1);
			//animTimer.addEventListener(TimerEvent.TIMER, makeBang);
			animTimer.addEventListener(TimerEvent.TIMER_COMPLETE, animFinished);
			//animStart();
			/*
			screen.x = -W / 2;
			screen.y = -H / 2;
			addChild(screen);*/
			//animStart();
			
		}
		
		public function destroy(e:Event = null):void {
			animStop();
			//animTimer.removeEventListener(TimerEvent.TIMER, makeBang);
			animTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, animFinished);
			animTimer = null;
			//screen.bitmapData = null;
			//screen = null;
		}
		
		private function animFinished(e:TimerEvent):void {
			removeChild(boom);
			dispatchEvent(new Event(EXPLODED));
			destroy();
		}
		private function makeBang(e:TimerEvent):void {
			screen.bitmapData.fillRect(new Rectangle(0, 0, W, H), 0);
			screen.bitmapData.copyPixels(explosion.bitmapData, new Rectangle((animTimer.currentCount - 1) * W, 0, W, H), new Point());
			
		}
		
		public function animStop():void {
			if (getChildByName("screen")) removeChild(screen);
			animTimer.stop();
			stopLightSound();
			
		}
		
		public function animStart():void {
			boom = new Boom();
			addChild(boom);
			animTimer.reset();
			playLightSound();
			animTimer.start();
		}
		
		
		
	}
	
}