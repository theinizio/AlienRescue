package Actors{
   
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.*;

	public class MusicButton extends SimpleButton {
		
		[Embed(source='../../lib/images.swf', symbol='musicbutton.png')]
		private var MusicButtonUp:Class;
		private var W:Number = 64;
		private var H:Number = 64;
		private var alfa:Number = 0.3;
		private var up:Bitmap;
		private var down:Bitmap;
		private var downSpr:Sprite;
		public var musicOn:Boolean = true;
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
        public var TapSndCls:Class;
        
        public var snd:Sound = new TapSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playSnd(e:MouseEvent = null):void {
			if(soundsAllowed)
				sndChannel = snd.play();
			
        }   
            
        public function stopSound():void {
            sndChannel.stop();
        }
		
		
		public function disable():void {
			musicOn = false;
			alpha = alfa;
		}
		private function enable():void {
			musicOn = true;
			alpha = 1;
		}
		
		
		public function MusicButton() {
			var f:DropShadowFilter = new DropShadowFilter();
			up   = new MusicButtonUp();
			up.filters = [f];
			down = new MusicButtonUp();
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
			addEventListener(MouseEvent.CLICK, changeState);
			x = 75;
			y = 432;
		}
		
		private function changeState(e:MouseEvent):void {
			e.updateAfterEvent();
			if (musicOn) {
				alpha = alfa;
			}else {
				alpha = 1;
			}
			musicOn = !musicOn;
			trace(musicOn, alpha);
		}
		
	}
}

