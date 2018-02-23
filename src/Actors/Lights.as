package Actors
{
	
	import flash.display.Bitmap;
	import flash.media.*;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Lights extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="world1city1.png")]
		private var World1city1Img:Class;
		
		[Embed (source ="../../lib/images.swf", symbol="world1city2.png")]
		private var World1city2Img:Class;
		
		[Embed (source ="../../lib/images.swf", symbol="world1city3.png")]
		private var World1city3Img:Class;
		
		[Embed (source ="../../lib/images.swf", symbol="world1city4.png")]
		private var World1city4Img:Class;
		
		[Embed(source="../sounds/lightsflicker.mp3")]
        [Bindable]
        public var sndCls:Class;
            
        private var snd:Sound = new sndCls() as Sound; 
        private var sndChannel:SoundChannel;
            
        private function playLightSound():void {
            sndChannel=snd.play();
        }   
            
        private function stopLightSound():void {
           if(sndChannel) sndChannel.stop();
        }
		
		
		

		private var speed:Number = 8;
		
		private var lights:Vector.<Bitmap> = new Vector.<Bitmap>(4, true);
		private var currentLight:int = 0;
		//private var name:String= "flag1";
		private var W:Number = 960;
		private var H:Number = 460;
		
		
		private var animTimer:Timer;
		private var rndTimer:Timer;
		private var normalState:Boolean = true;
		private var soundsAllowed:Boolean = true;
		
		
		
		public function Lights() {
			lights[0] = new World1city1Img();
			lights[1] = new World1city2Img();
			lights[2] = new World1city3Img();
			lights[3] = new World1city4Img();
			lights[0].smoothing = true;
			lights[1].smoothing = true;
			lights[2].smoothing = true;
			lights[3].smoothing = true;
		
			addChild(lights[0]);
			W = width;
			H = height;
			
			animTimer = new Timer(800);
			animTimer.addEventListener(TimerEvent.TIMER, timerAnimationHandler);
			animTimer.start();
		
			rndTimer = new Timer(40,20);
			rndTimer.addEventListener(TimerEvent.TIMER, blinking);
			rndTimer.addEventListener(TimerEvent.TIMER_COMPLETE,rndTimerComplete);
		}
		
		private function rndTimerComplete(e:TimerEvent):void {
			if (!normalState) {
					removeChild(lights[currentLight]);
					addChild(lights[0]);
					normalState = true;
				}
		}
		private function blinking(e:TimerEvent):void {
			if (Math.round(Math.random() * 8)) {
				
				if (!normalState) {
					removeChild(lights[currentLight]);
					addChild(lights[0]);
				}else {
					removeChild(lights[0]);
					addChild(lights[currentLight]);
				}
				normalState = !normalState;
				
			}
		}
		
		private function timerAnimationHandler(e:TimerEvent):void {
			
			if ((!Math.round(Math.random() * 4)) && (!rndTimer.running)) {
				
				currentLight = Math.round(Math.random() * 2) + 1;
				rndTimer.reset();
				rndTimer.start();
				if(soundsAllowed)
					playLightSound();
			}
		}
		
		public function animStop():void {
			stopLightSound();
			animTimer.stop();
		}
		
		public function animStart():void {
			animTimer.start();
		}
		
		public function stopSounds():void {
			stopLightSound();
			soundsAllowed = false;
		}
		public function startSounds():void {
			soundsAllowed = true;
		}
		
		
		
		public function destroy():void {
			stopLightSound();
			rndTimer.stop();
			rndTimer.removeEventListener(TimerEvent.TIMER, blinking);
			rndTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, rndTimerComplete);
			rndTimer = null;
			animTimer.stop();
			animTimer.removeEventListener(TimerEvent.TIMER, timerAnimationHandler);
			animTimer = null;
			if (!normalState) removeChild(lights[currentLight]);
			else removeChild(lights[0]);
			for (var i:uint = 0; i < lights.length; i++) {
				lights[i] = null;
			}
			lights = null;
			snd = null;
			sndChannel = null;
		}
		
	}
	
}