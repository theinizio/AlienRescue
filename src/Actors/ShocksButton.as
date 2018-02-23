package Actors{
   
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.*;
	import flash.utils.Timer;

	public class ShocksButton extends SimpleButton {
		
		[Embed (source ="../../lib/images.swf", symbol="shocks.png")]
		private var ShocksUp:Class;
		[Embed (source ="../../lib/images.swf", symbol="shocks2.png")]
		private var ShocksDown:Class;
		
		private var up:Bitmap;
		private var down:Bitmap;
		private var upClear:Bitmap;
		
		
		private var W:Number = 64;
		private var H:Number = 64;
		private var alfa:Number = 0.3;
		
		private var downSpr:Sprite;
		private var upSpr:Sprite;
		private var animTimer:Timer;
		
		//[Embed(source="../sounds/zapubutton.mp3")]
		[Embed(source='../../lib/images.swf', symbol='TeleportSound')]
        [Bindable]
        public var ShocksSndCls:Class;
        private var volume:Number = 0.114458;    
        private var snd:Sound = new ShocksSndCls() as Sound; 
        private var sndChannel:SoundChannel;
        private var soundsAllowed:Boolean = true;
		public function stopSounds():void {
			stopSound();
			soundsAllowed = false;
		}
		public function startSounds():void {
			soundsAllowed = true;
		}  
        private function playSnd(e:MouseEvent = null):void {
			up.visible = false;
			upClear.visible = true;
			if(soundsAllowed){
				sndChannel = snd.play();
				sndChannel.soundTransform = new SoundTransform(volume);
			}
        }   
            
        private function stopSound():void {
           if(sndChannel) sndChannel.stop();
        }
		
		
		private function removedFromStage(e:Event):void {
			animTimer.removeEventListener(TimerEvent.TIMER, animate);
			animTimer.stop();
		}
		private function addedToStage(e:Event):void{
			animTimer.addEventListener(TimerEvent.TIMER, animate);
		}
		
		public function ShocksButton() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		
			animTimer = new Timer(50, 65);
			var f:DropShadowFilter = new DropShadowFilter();
			up   = new ShocksUp();
			upClear = new ShocksDown();
			upClear.filters = [f];
			up.filters = [f];
			
			down = new ShocksUp();
			downSpr = new Sprite();
			down.y += 1;
			down.x -= 1;
			downSpr.addChild(down);
			
			upSpr = new Sprite();
			
			upSpr.addChild(upClear);
			upClear.visible = false;
			upSpr.addChild(upClear);
			upSpr.addChild(up);
			downState      = downSpr;
			overState      = upSpr;
			upState        = upSpr;
			hitTestState   = downSpr;
			
			useHandCursor  = true;
			addEventListener(MouseEvent.MOUSE_DOWN, playSnd);
			x = 530;
			y = 5;
		}
		
		
		private function animate(e:TimerEvent):void {
			e.updateAfterEvent();
			
			if (animTimer.currentCount % 2) {
			alpha = .4;
				
			}else {
				alpha = 1;
			}
			
		}
		
		public function animStart():void {
			
			animTimer.start();
		}
		public function animStop():void {
			animTimer.stop();
		}
		public function enable():void {
			enabled = true;
			mouseEnabled = true;
			alpha = 1;
			//addEventListener(MouseEvent.MOUSE_UP, playSnd);
		}
		public function disable():void {
			animTimer.stop();
			enabled = false;
			mouseEnabled = false;
			alpha = 0.3;
			//removeEventListener(MouseEvent.MOUSE_UP, playSnd);
		}
	}
}


