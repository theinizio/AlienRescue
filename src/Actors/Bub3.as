package Actors
{
	import Parameters;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.*;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Bub3 extends Sprite
	{
		[Embed(source='../../lib/images.swf', symbol='bub3.png')]
		private var Actor19Img:Class;
		public var img:Bitmap;
		
		//private var name:String= "Actor19";
		private var W:Number;
		private var H:Number;
		
		public var dynamicBody:b2Body;
		private var dynamicBodyDefination:b2BodyDef;
		private var dynamicShapeDefination:b2PolygonShape;
		private var fixtureDef:b2FixtureDef;
		private var world:b2World;
	
		private var physScale:Number = Parameters.physScale;
		private var friction:Number = Parameters.bubFriction;
		private var restitution:Number = Parameters.bubRestitution;
		private var density:Number = Parameters.bubDensity;
		
		private var soundsAllowed:Boolean = true;
		public function stopSounds():void {
			stopSound();
			soundsAllowed = false;
		}
		public function startSounds():void {
			soundsAllowed = true;
		}
		[Embed(source='../../lib/images.swf', symbol='DelSound')]
        [Bindable]
        public var WoodSndCls:Class;
            
        public var snd:Sound = new WoodSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playWoodSnd():void {
			if(soundsAllowed){
				sndChannel = snd.play();
				sndChannel.soundTransform = new SoundTransform(0.331325);
			}
        }   
            
        public function stopSound():void {
            if (sndChannel) sndChannel.stop();
			if(dsndChannel)dsndChannel.stop();
        }
		
		[Embed(source='../../lib/images.swf', symbol='DelSound')]
        [Bindable]
        public var DestroySndCls:Class;
            
        public var dsnd:Sound = new DestroySndCls() as Sound; 
        public var dsndChannel:SoundChannel;
            
        public function playDestroySnd(e:MouseEvent=null):void {
			if(soundsAllowed){
				dsndChannel = dsnd.play();
				if(dsndChannel)dsndChannel.soundTransform = new SoundTransform(0.271084);
				if(dsndChannel)dsndChannel.addEventListener(Event.SOUND_COMPLETE, destroy2);
			}else { destroy(); destroy2();}
        }   
            
    		

		
		public function Bub3(World:b2World, X:Number = 0, Y:Number = 0, rot:Number = 0) {
			world = World;
			x = X;
			y = Y;
			rotation = rot;
			init();
		
		}
		
		public function destroy():void {
			if (dynamicBody){
				trace(dynamicBody.GetLocalCenter().y);
				world.DestroyBody(dynamicBody);
			}
			//playDestroySnd();			
			dynamicBody = null;
			dynamicBodyDefination = null;
			dynamicShapeDefination = null;
			fixtureDef = null;
			removeEventListener(MouseEvent.CLICK, playDestroySnd);
			
		}
		
		
		public function destroy2(e:Event=null):void {
			
		//	removeChild(img); img = null;
		}
		
		
		
		
		
		
		public function init():void {
			
				addEventListener(MouseEvent.CLICK, playDestroySnd);
			
			img = new Actor19Img();
			img.smoothing = true;
			W = img.width;
			H = img.height;
			trace(W, H);
			img.x = -W/2;
			img.y = -H/2;
			
			
			
			addChild(img);
			
			
			dynamicBodyDefination = new b2BodyDef();
			dynamicBodyDefination.position.Set(x / physScale, y / physScale);
			dynamicBodyDefination.userData = this;
			dynamicBodyDefination.type = b2Body.b2_dynamicBody;
			
			dynamicShapeDefination = new b2PolygonShape();
			dynamicShapeDefination.SetAsBox((W-0) / physScale /2, (H-0) / physScale /2);
			fixtureDef = new b2FixtureDef();
			
			fixtureDef.density = density;		// коефициент плотности объекта
			fixtureDef.friction = friction; 		// коефициент трения объекта
			fixtureDef.restitution = restitution; 	// коефициент упругости
			fixtureDef.userData = "bub";
			fixtureDef.shape = dynamicShapeDefination;
			dynamicBody = world.CreateBody(dynamicBodyDefination);
			dynamicBody.CreateFixture(fixtureDef);
			
			dynamicBody.SetSleepingAllowed(false);
			dynamicBody.SetFixedRotation(false);
			dynamicBody.ApplyForce(new b2Vec2(0, Parameters.bubForce*2), dynamicBody.GetWorldCenter());
			
		}
		
		
		
		public function setPosition(vec:b2Vec2):void {
			dynamicBody.SetPosition(vec);
			x = vec.x;
			y = vec.y;
		}
		
		
		public function setRotation(rot:Number):void {
			dynamicBody.SetAngle( rot);
			rotation = rot;
		}
		
		
	}
	
}