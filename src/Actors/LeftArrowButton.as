package Actors{
   
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.*;

	public class LeftArrowButton extends SimpleButton {
		
		[Embed (source ="../../lib/images.swf", symbol="leftarrow.png")]
		private var LeftArrowUp:Class;
		private var W:Number = 64;
		private var H:Number = 64;
		private var alfa:Number = 0.25;
		private var up:Bitmap;
		private var down:Bitmap;
		private var downSpr:Sprite;
	
		private var soundsAllowed:Boolean = true;
		public function stopSounds():void {
			stopSound();
			soundsAllowed = false;
		}
		public function startSounds():void {
			soundsAllowed = true;
		}
		[Embed(source='../../lib/images.swf', symbol='ClickSound')]
        [Bindable]
        public var KnockWoodSndCls:Class;
        private var volume:Number = 0.5;    
        public var snd:Sound = new KnockWoodSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playSnd(e:MouseEvent = null):void {
			if(soundsAllowed){
				sndChannel = snd.play();
				if(sndChannel)sndChannel.soundTransform = new SoundTransform(volume);
			}
        }   
            
        public function stopSound():void {
            if (sndChannel)
				sndChannel.stop();
        }
		
		
		
		
		
		
		public function LeftArrowButton() {
			var f:DropShadowFilter = new DropShadowFilter();
			up   = new LeftArrowUp();
			up.filters = [f];
			down = new LeftArrowUp();
			down.smoothing = true;
			up.smoothing = true;
			W = up.width;
			H = up.height;
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
			x = 172;
			y = 432;
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


