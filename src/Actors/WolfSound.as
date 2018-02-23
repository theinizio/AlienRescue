package Actors
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.media.*;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class WolfSound 
	{
		
		public var name:String = "Actor49";	
		private var red:Number = 0.054205; 
		private var blue:Number = 0.148349;

		private var visible:Boolean = false;
		private var movable:Boolean = false;
		private var volume:Number = .5;
		private var rndTimer:Timer;
		
		
		[Embed(source="../sounds/wold.mp3")]
        [Bindable]
        public var WoldsndCls:Class;
            
        public var snd:Sound = new WoldsndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
       private function playLightSound():void {
            sndChannel = snd.play();
			if(sndChannel)  sndChannel.soundTransform = new SoundTransform(volume);
			
        }   
            
        private function stopLightSound():void {
          if(sndChannel)  sndChannel.stop();
        }
		
		
		public function soundOn():void {
			//trace("WolfSoundON");
			rndTimer.start();
		}
		
		public function soundOff():void {
			rndTimer.stop();
			stopLightSound();
			//trace("WolfSoundOFF");
		}
		
		
		
		public function WolfSound() {
		
			rndTimer = new Timer(4000);
			rndTimer.addEventListener(TimerEvent.TIMER, rndTimerEvent);
			rndTimer.start();
		}
		
		private function rndTimerEvent(e:TimerEvent):void {
			if (Math.round(Math.random() * .8)) playLightSound();
		}
		
		public function destroy():void {
			rndTimer.stop();
			rndTimer.removeEventListener(TimerEvent.TIMER, rndTimerEvent);
			rndTimer = null;
			stopLightSound();
			snd = null;
			sndChannel = null;
		}
		
		
		
		
		
		
		
		
		
		
	}
	
}