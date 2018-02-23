package Actors{
   
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.b2Body;
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

	public class Logo extends SimpleButton {
		public static const ANIM_FINISHED:String = "animFinished";
		[Embed(source='../../lib/images.swf', symbol='logo.jpg')]
		private var LeftArrowUp:Class;
		private var W:Number = 64;
		private var H:Number = 64;
		private var alfa:Number = 0.25;
		private var up:Bitmap;
		private var down:Bitmap;
		private var downSpr:Sprite;
		private var upSpr:Sprite;
		
		private var physScale:Number = Parameters.physScale;
		private var world:PhysWorld;
		[Embed(source="../sounds/popsound.mp3")]
        [Bindable]
        public var PopSndCls:Class;
        private var volume:Number = 0.5;    
        public var snd:Sound = new PopSndCls() as Sound; 
        public var sndChannel:SoundChannel;
        private var timer:Timer;
        public function playSnd(e:MouseEvent = null):void {
			removeEventListener(MouseEvent.MOUSE_DOWN, playSnd);
			enabled = false;
			mouseEnabled = false;
			
            sndChannel = snd.play();
			sndChannel.soundTransform = new SoundTransform(volume);
			dispatchEvent(new Event(ANIM_FINISHED));
        }   
            
		
		
        public function stopSound():void {
            if (sndChannel)
				sndChannel.stop();
        }
		
		public function destroy(e:Event = null):void {
			
			stopSound();
			removeEventListener(MouseEvent.MOUSE_DOWN, playSnd);
			
			
			
		}
		
		
		
		
		public function Logo(World:PhysWorld) {
			world = World;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		private function init(e:Event):void {
			
			
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
			addEventListener(MouseEvent.MOUSE_DOWN, playSnd);
		}
		
		
	
	}
}


