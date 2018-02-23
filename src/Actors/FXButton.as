package Actors{
   
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.*;

	public class FXButton extends SimpleButton {
		
		[Embed (source ="../../lib/images.swf", symbol="fxbutton.png")]
		private var FXButtonUp:Class;
		private var W:Number = 64;
		private var H:Number = 64;
		private var alfa:Number = 0.3;
		private var up:Bitmap;
		private var down:Bitmap;
		private var downSpr:Sprite;
		public var FXOn:Boolean = true;
		
		[Embed(source='../../lib/images.swf', symbol='ClickSound')]
        [Bindable]
        public var TapSndCls:Class;
        
        public var snd:Sound = new TapSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playSnd(e:MouseEvent = null):void {
			
            sndChannel = snd.play();
			
        }   
            
        public function stopSound():void {
            sndChannel.stop();
        }
		
		
		public function disable():void {
			FXOn = false;
			alpha = alfa;
		}
		private function enable():void {
			FXOn = true;
			alpha = 1;
		}
		
		
		
		public function FXButton() {
			var f:DropShadowFilter = new DropShadowFilter();
			up   = new FXButtonUp();
			
			up.filters = [f];
			down = new FXButtonUp();
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
			x = 7;
			y = 432;
		}
		
		private function changeState(e:MouseEvent):void {
			e.updateAfterEvent();
			if (FXOn) {
				alpha = alfa;
			}else {
				alpha = 1;
			}
			FXOn = !FXOn;
			trace(FXOn, alpha);
		}
		
	}
}

