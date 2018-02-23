package Actors{
   
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.*;

	public class World1Button extends SimpleButton {
		
		[Embed(source='../../lib/images.swf', symbol='world1.png')]
		//[Embed(source='../images/world1.png')]
		private var World1Up:Class;
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
           if(sndChannel) sndChannel.stop();
        }
		
		
		
		
		
		
		public function World1Button() {
			var f:DropShadowFilter = new DropShadowFilter();
			up   = new World1Up();
			up.filters = [f];
			down = new World1Up();
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
	}
}

