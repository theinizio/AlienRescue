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

	public class RefreshButton extends SimpleButton {
		
		[Embed (source ="../../lib/images.swf", symbol="refresh.png")]
		private var RefreshUp:Class;
		private var animTimer:Timer;
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
				if(sndChannel)sndChannel = snd.play();
			animStop();
        }   
            
        public function stopSound():void {
            if(sndChannel)sndChannel.stop();
        }
		
		
			private function animate(e:TimerEvent):void {
			e.updateAfterEvent();
			
			if (animTimer.currentCount % 2) {
				up.alpha = 1;
				
				
			}else {
			up.alpha = 0.3;
			}	
		}
		
		
		private function removedFromStage(e:Event):void {
			animTimer.removeEventListener(TimerEvent.TIMER, animate);
			animTimer.stop();
		}
		private function addedToStage(e:Event):void{
			animTimer.addEventListener(TimerEvent.TIMER, animate);
		}
		
		
		public function animStart():void {
			
			animTimer.start();
		}
		public function animStop():void {
			up.alpha = 1;
			animTimer.stop();
		}
		
		
		
		
		
		public function RefreshButton() {
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		
			animTimer = new Timer(50, 65);
			
			
			
			up   = new RefreshUp();
			
			var f:DropShadowFilter= new DropShadowFilter();
			up.filters = [f];
			down = new RefreshUp();
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
			
			x = 556;
			y = 442;
			useHandCursor  = true;
			addEventListener(MouseEvent.MOUSE_UP, playSnd);
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


