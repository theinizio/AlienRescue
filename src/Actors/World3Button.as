package Actors{
   
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.*;

	public class World3Button extends SimpleButton {
		
		[Embed (source ="../../lib/images.swf", symbol="world3.png")]
		private var World3Up:Class;
		[Embed (source ="../../lib/images.swf", symbol="worldlockedimage.png")]
		private var WorldLock:Class;
		private var lockImg:Bitmap;
		private var W:Number = 212;
		private var H:Number = 348;
		
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
		
		[Embed(source="../sounds/popsound.mp3")]
        [Bindable]
        public var PopSndCls:Class;
        private var volume:Number = 0.5;    
        public var snd:Sound = new PopSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playSnd(e:MouseEvent = null):void {
			if(soundsAllowed){
				sndChannel = snd.play();
				sndChannel.soundTransform = new SoundTransform(volume);
			}
        }   
            
        public function stopSound():void {
           if (sndChannel) sndChannel.stop();
        }
		
		
		
		public function World3Button() {
			lockImg = new WorldLock();
			lockImg.smoothing = true;
			
			var f:DropShadowFilter = new DropShadowFilter();
			up   = new World3Up();
			up.filters = [f];
			down = new World3Up();
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
			addEventListener(MouseEvent.MOUSE_DOWN, playSnd);
		}
		public function enable():void {
			enabled = true;
			mouseEnabled = true;
			downState      = downSpr;
			overState      = up;
			upState        = up;
			hitTestState   = downSpr;
			addEventListener(MouseEvent.MOUSE_DOWN, playSnd);
		}
		public function disable():void {
			enabled = false;
			mouseEnabled = false;
			upState = lockImg;
			downState = lockImg;
			overState = lockImg;
			removeEventListener(MouseEvent.MOUSE_DOWN, playSnd);
		}
		
		
	}
}

