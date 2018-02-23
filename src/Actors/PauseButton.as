package Actors{
   
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.*;

	public class PauseButton extends SimpleButton {
		
		[Embed (source ="../../lib/images.swf", symbol="pause.png")]
		private var PauseUp:Class;
		
		private var soundsAllowed:Boolean = true;
		public function stopSounds():void {
			stopSound();
			soundsAllowed = false;
		}
		public function startSounds():void {
			soundsAllowed = true;
		}
		private var up:Bitmap;
		private var down:Bitmap;
		private var downSpr:Sprite;
		
		[Embed(source='../../lib/images.swf', symbol='ClickSound')]
        [Bindable]
        public var ExplSndCls:Class;
            
        public var snd:Sound = new ExplSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playSnd(e:MouseEvent = null):void {
			if(soundsAllowed)
				sndChannel=snd.play();
        }   
            
        public function stopSound():void {
           if(sndChannel) sndChannel.stop();
        }
		
		
		
		
		
		
		public function PauseButton() {
			up   = new PauseUp();
			var f:DropShadowFilter= new DropShadowFilter();
			up.filters = [f];
			down = new PauseUp();
			down.smoothing = true;
			up.smoothing = true;
			
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
			x = 7;
			y = 442;
			
			
		}
		
		public function enable():void {
			enabled = true;
			mouseEnabled = true;
			alpha = 1;
		}
		public function disable():void {
			enabled = false;
			mouseEnabled = false;
			alpha = 0.3;
		}
		
	
	}
}


