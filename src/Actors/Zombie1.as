package Actors
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Parameters;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.media.*;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Zombie1 extends Sprite
	{
		public static const EXPLODED:String = "exploded";
		
		
		[Embed(source='../../lib/images.swf', symbol='zombie2b.png')]
		private var Actor1Img:Class;
		public var img:Bitmap;
		[Embed(source='../../lib/zombie.swf', symbol='Alien')]
		private var Anim:Class;
		private var anim:MovieClip;
		//private var name:String= "Actor1";
		private var W:Number=88;
		private var H:Number=80;
		
		private var dynamicBody:b2Body;
		private var dynamicBodyDefination:b2BodyDef;
		private var dynamicShapeDefination:b2PolygonShape;
		private var fixtureDef:b2FixtureDef;
		private var world:b2World;
		private var soundsAllowed:Boolean = true;
		private var burned:Boolean;
		
		public function stopSounds():void {
			
			soundsAllowed = false;
		}
		public function startSounds():void {
			soundsAllowed = true;
			
		} 
		
		private var physScale:Number = Parameters.physScale;
		private var density:Number = Parameters.zombieDensity;
		private var restitution:Number=Parameters.zombieRestitution;
		private var friction:Number = Parameters.zombieFriction;
		private var animTimer:Timer;
		
		
		
		
		
		public function explode():void {
		
			addChild(anim);
			animTimer.start();
			world.DestroyBody(dynamicBody);
		
		
			if(contains(img))removeChild(img);
			burned = true;
		}
		
		
		public function Zombie1(World:b2World, X:Number = 0, Y:Number = 0, rot:Number = 0) {
			
			
			world = World;
			x = X;
			y = Y;
			rotation = rot;
			init();
		}
		
		public function destroy():void {
			animTimer.stop();
			animTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, animFinished);
			animTimer = null;
			
			if (burned) {
		
				if(contains(anim))removeChild(anim);
			}else{
				removeChild(img); img = null;
				if(!bodyDestroyed)
					world.DestroyBody(dynamicBody);
			}
			bodyDestroyed = false;
			dynamicBody = null;
			dynamicBodyDefination = null;
			dynamicShapeDefination = null;
			fixtureDef = null;
			
		
		}
		
		
		private function animFinished(e:Event):void {
			removeChild(anim);
			dispatchEvent(new Event(Zombie1.EXPLODED));
		}
		
		private var bodyDestroyed:Boolean = false;
		public function destoyBody():void {
			bodyDestroyed = true;
			world.DestroyBody(dynamicBody);
			
		}
		
		
		public function init():void {
			
			animTimer = new Timer(667, 1);
			animTimer.addEventListener(TimerEvent.TIMER_COMPLETE, animFinished);
			anim = new Anim();
			img = new Actor1Img();
			img.smoothing = true;
			W = img.width;
			H = img.height;
			
			img.x = -W/2;
			img.y = -H/2;
			
			anim.x -= anim.width / 2;
			anim.y -= anim.height/2;
			

			addChild(img);
			
			
			dynamicBodyDefination = new b2BodyDef();
			dynamicBodyDefination.position.Set(x / physScale, y / physScale);
			dynamicBodyDefination.userData = this;
			dynamicBodyDefination.type = b2Body.b2_dynamicBody;
			
			dynamicShapeDefination = new b2PolygonShape();
			dynamicShapeDefination.SetAsBox((W-0) / physScale /2, (H-0) / physScale /2);
			fixtureDef = new b2FixtureDef();
			
			fixtureDef.density = density;		// коефициент плотности объекта
			//fixtureDef.friction = friction; 		// коефициент трения объекта
			fixtureDef.restitution = restitution; 	// коефициент упругости
			fixtureDef.shape = dynamicShapeDefination;
			fixtureDef.userData = "zombie";
			dynamicBody = world.CreateBody(dynamicBodyDefination);
			dynamicBody.CreateFixture(fixtureDef);
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