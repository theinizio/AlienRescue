package Actors{
   
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.*;

	public class ResetButton extends SimpleButton {
		
		[Embed(source='../../lib/images.swf', symbol='resetnew.png')]
		private var ResetButtonUp:Class;
		
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
		
		[Embed(source="../sounds/knock wood.mp3")]
        [Bindable]
        public var KnockWoodSndCls:Class;
        private var volume:Number = 0.5;    
        public var snd:Sound = new KnockWoodSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playSnd(e:MouseEvent = null):void {
			if(soundsAllowed){
				sndChannel = snd.play();
				sndChannel.soundTransform = new SoundTransform(volume);
			}
        }   
            
        public function stopSound():void {
            sndChannel.stop();
        }
		
		
		
		
		
		
		public function ResetButton() {
			up   = new ResetButtonUp();
			var f:DropShadowFilter = new DropShadowFilter();
			up.filters = [f];
			down = new ResetButtonUp();
			downSpr = new Sprite();
			down.y += 1;
			down.x -= 1;
			downSpr.addChild(down);
			
			//changeAlpha(alfa);
			downState      = downSpr;
			overState      = up;
			upState        = up;
			hitTestState   = downSpr;
			x = 526;
			y = 422;
			useHandCursor  = true;
			addEventListener(MouseEvent.MOUSE_UP, playSnd);
		}
		public function changeAlpha(alpha:Number):void {
			if ((alpha > 0) && (alpha < 1.0)) {
				alfa = alpha;
				up.alpha = alfa;
				down.alpha = alfa;
			}
			
		}
	
	}
}


