package Actors
{
	
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
	public class Zombie3Explosion extends Sprite
	{
		public static const ANIMATION_FINISHED:String = "animationFinished";
		
		
		[Embed(source='../../lib/images.swf', symbol='Zombie3Explosion.png')]
		private var Z3ExplImg:Class;
		private var explosion:Bitmap;
		
		
		private var volume1:Number = 0.5;
		private var volume2:Number = 0.210843;
		private var screen:Bitmap;
		//private var name:String= "flag1";
		public var W:Number = 160;
		public var H:Number = 140;
		private var speed:int = 30;//?
		private var framesCount:uint = 13;
		private var animTimer:Timer;
		 private var soundsAllowed:Boolean = true;
		public function stopSounds():void {
			stopSound();
			soundsAllowed = false;
		}
		public function startSounds():void {
			soundsAllowed = true;
		} 
		
		[Embed(source="../sounds/zapubutton.mp3")]
        [Bindable]
        public var sndCls:Class;
            
        public var snd:Sound = new sndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playSounds():void {
			if(soundsAllowed){
				sndChannel = snd.play();
				sndChannel.soundTransform = new SoundTransform(volume1);
				 screamSndChannel = screamSnd.play();
				screamSndChannel.soundTransform = new SoundTransform(volume2);
			}
        }   
            
        public function stopSound():void {
          if (sndChannel)  sndChannel.stop();
		  if(screamSndChannel)screamSndChannel.stop();
        }
		
		[Embed(source="../sounds/scream1Pitch.mp3")]
        [Bindable]
        public var ScreamSndCls:Class;
            
        public var screamSnd:Sound = new ScreamSndCls() as Sound; 
        public var screamSndChannel:SoundChannel;
      
		
		
		
		
		
		
		
		
		
		
		public function Zombie3Explosion() {
			
			explosion = new Z3ExplImg();
			
			screen = new Bitmap();
			explosion.smoothing = true;
			screen.smoothing = true;
			W = explosion.width / framesCount;
			H = explosion.height;
			screen.bitmapData = new BitmapData(W, H, true, 0);
			
			animTimer = new Timer(237, framesCount);
			animTimer.addEventListener(TimerEvent.TIMER, makeBang);
			animTimer.addEventListener(TimerEvent.TIMER_COMPLETE, animFinished);
			
			
		}
		private function animFinished(e:TimerEvent):void {
			//removeChild(screen);
			dispatchEvent(new Event(Zombie1Explosion.ANIMATION_FINISHED));
		}
		private function makeBang(e:TimerEvent):void {
			screen.bitmapData.fillRect(new Rectangle(0, 0, W, H), 0);
			screen.bitmapData.copyPixels(explosion.bitmapData, new Rectangle((animTimer.currentCount - 1) * W, 0, W, H), new Point());
			//trace("SND POs=" + sndChannel.position);
		}
		
		public function animStop():void {
			if (getChildByName("screen")) removeChild(screen);
			animTimer.stop();
			stopSounds();
		}
		
		public function animStart():void {
			addChild(screen);
			animTimer.reset();
			playSounds();
			animTimer.start();
		}
		
		public function destroy():void {
			animStop();
			animTimer.removeEventListener(TimerEvent.TIMER, makeBang);
			animTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, animFinished);
			animTimer = null;
			screen.bitmapData = null;
			screen = null;
			explosion = null;
			snd = null;
			if (sndChannel) sndChannel = null;
			
		}
		
	}
	
}