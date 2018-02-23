package 
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class ContactListener extends b2ContactListener 
	{
		
		private var physWorld:PhysWorld;
		
		[Embed(source='../lib/images.swf', symbol='StoneSound')]
		private var WoodSnd:Class;
		[Embed(source='../lib/images.swf', symbol='RubberSound')]
		private var TireSnd:Class;
		[Embed(source='../lib/images.swf', symbol='BubSound')]
		private var BubSnd:Class;
		private var woodSnd:Sound;
		private var tireSnd:Sound;
		private var bubSnd:Sound;
		private var sndChannel:SoundChannel;
		public var soundsAllowed:Boolean = true;
		public var volume:Number = .5;
		public var metToAnimate:*;
		
		
		private function playWoodSound():void {
			if(soundsAllowed){
				sndChannel = woodSnd.play();
				if (sndChannel)
					sndChannel.soundTransform = new SoundTransform(volume);
			}
		}
		
		private function playTireSound():void {
			if (soundsAllowed) {
				sndChannel = tireSnd.play();
				if(sndChannel)
					sndChannel.soundTransform = new SoundTransform(volume);
			}
		}
		private function playBubSound():void {
			if (soundsAllowed) {
				sndChannel = bubSnd.play();
				if(sndChannel)
					sndChannel.soundTransform = new SoundTransform(volume);
			}
		}
		public function stopSounds():void {
			soundsAllowed = false;
			if (sndChannel)
				sndChannel.stop();
		}
		
		public function startSounds():void {
			soundsAllowed = true;
		}
		
		public var groundContact:Boolean;
		public var metContact:Boolean;
		
		public function ContactListener() {
			tireSnd = new TireSnd();
			//tireSnd = new RubberSound();
			woodSnd = new WoodSnd();
		}
		
		public function setPhysWorld(w:PhysWorld):void {
			physWorld = w;
		}
		
		public override function BeginContact(contact:b2Contact):void
		{
			
			var fx1:*= contact.GetFixtureA().GetUserData();
			var fx2:*= contact.GetFixtureB().GetUserData();
			if ((fx1 == "tire") || (fx2 == "tire")) playTireSound();
			if ((fx1 == "wood") || (fx2 == "wood")) playWoodSound();
			if (((fx1 == "zombie") && (fx2 == "ground") || ((fx2 == "zombie") && (fx1 == "ground")))) {
				physWorld.dispathFailEvent();
				groundContact = true;
			}	
			if ((fx1 == "zombie") && (fx2 == "met")){
				contact.GetFixtureA().GetBody().SetAngle(0);
				metContact = true;
				metToAnimate = contact.GetFixtureB().GetBody().GetUserData();
			}
			
		} 
		public override function EndContact(contact:b2Contact):void
		{
			var fx1:*= contact.GetFixtureA().GetUserData();
			var fx2:*= contact.GetFixtureB().GetUserData();
			if((fx1=="zombie")&&(fx2=="ground"))
				groundContact =false;
				
			if ((fx1 == "zombie") && (fx2 == "met")) {
				//metToAnimate = null;
				metContact = false;
			}
		}
 
		public override function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void
		{
			
			
		}
 
		public override function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void
		{
			
		
				
		}
	}
	
}