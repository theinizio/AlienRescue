package Actors{
   
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.*;
	import flash.utils.Timer;

	public class FailButton extends SimpleButton {
		
		[Embed (source ="../../lib/images.swf", symbol="fail.png")]
		private var FailUp:Class;
		private var upSpr:Sprite;
		
		
		private var up:Bitmap;
		private var down:Bitmap;
		private var downSpr:Sprite;
		private var W:Number = 320;
		private var H:Number = 160;
		private var soundsAllowed:Boolean = true;
		public function stopSounds():void {
			stopSound();
			soundsAllowed = false;
		}
		public function startSounds():void {
			soundsAllowed = true;
		}
		[Embed(source='../../lib/images.swf', symbol='FailSound')]
        [Bindable]
        public var FailSndCls:Class;
            
        public var snd:Sound = new FailSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playSnd(e:MouseEvent = null):void {
			if(soundsAllowed)
				sndChannel = snd.play();
			
        }   
            
        public function stopSound():void {
           if(sndChannel) sndChannel.stop();
        }
		
		
	
		
		public function FailButton() {
			
			
			up   = new FailUp();
			up.smoothing = true;
			W = up.width;
			H = up.height;
			var f:DropShadowFilter= new DropShadowFilter();
			up.filters = [f];
			down = new FailUp();
			down.smoothing = true;
			downSpr = new Sprite();
			down.y += 1;
			down.x -= 1;
			downSpr.addChild(down);
			
			
			downState      = downSpr;
			overState      = up;
			upState        = up;
			hitTestState   = downSpr;
			
			useHandCursor  = true;
			addEventListener(MouseEvent.MOUSE_UP, playSnd);
			
			x = (630 - W) / 2;
			y = (420 - H) / 2;;
		}
	
	}
}


