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
	import flash.events.MouseEvent;
	import flash.media.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Tire3 extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="tire3.png")]
		private var Actor25Img:Class;
		public var img:Bitmap;
		
		//private var name:String= "Actor25";
		private var W:Number=64;
		private var H:Number=64;
		
		private var dynamicBody:b2Body;
		private var dynamicBodyDefination:b2BodyDef;
		private var dynamicShapeDefination:b2PolygonShape;
		private var fixtureDef:b2FixtureDef;
		private var world:b2World;
	
		private var physScale:Number = Parameters.physScale;
		private var friction:Number = Parameters.tireFriction;
		private var restitution:Number = Parameters.tireRestitution;
		private var density:Number = Parameters.tireDensity;
		
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
        private var TireSndCls:Class;
            
        private var snd:Sound = new TireSndCls() as Sound; 
        private var sndChannel:SoundChannel;
            
        private function playSnd(e:MouseEvent=null):void {
			if(soundsAllowed)
				sndChannel=snd.play();
        }   
            
        private function stopSound():void {
            if (sndChannel)
				sndChannel.stop();
        }
		
		
		public function Tire3(World:b2World, X:Number = 0, Y:Number = 0, rot:Number = 0) {
			world = World;
			x = X;
			y = Y;
			rotation = rot;
			init();
		
		}
		
		public function destroy():void {
			removeEventListener(MouseEvent.CLICK, playSnd);
			removeChild(img); img = null;
			
			world.DestroyBody(dynamicBody);
			dynamicBody = null;
			dynamicBodyDefination = null;
			dynamicShapeDefination = null;
			fixtureDef = null;
			
		}
		
		
		
		
		
		
		
		
		public function init():void {
			
			addEventListener(MouseEvent.CLICK, playSnd);
			
			img = new Actor25Img();
			img.smoothing = true;
			W = img.width;
			H = img.height;
			
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
			fixtureDef.userData = "tire";
			fixtureDef.shape = dynamicShapeDefination;
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