package Actors.last
{
	import Actors.Explosion;
	import Parameters;
	import Box2D.Collision.b2DistanceInput;
	import Box2D.Collision.b2Distance;
	import Box2D.Collision.b2DistanceOutput;
	import Box2D.Collision.b2DistanceProxy;
	import Box2D.Collision.b2SimplexCache;
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
	public class Tnt5 extends Sprite
	{
		[Embed(source='../../../lib/95.swf', symbol='tnt5.png')]
		private var Actor41Img:Class;
		public var img:Bitmap;
		
		//private var name:String= "Actor41";
		private var W:Number;
		private var H:Number;
		private var expl:Explosion;
		private var dynamicBody:b2Body;
		private var dynamicBodyDefination:b2BodyDef;
		private var dynamicShapeDefination:b2PolygonShape;
		private var fixtureDef:b2FixtureDef;
		private var world:b2World;
		private var bodiesList:b2Body;
		
		private var physScale:Number = Parameters.physScale;
		private var friction:Number = Parameters.tntFriction;
		private var density:Number = Parameters.tntDensity;
		private var restitution:Number=Parameters.tntRestitution;
		
		private var soundsAllowed:Boolean = true;
		public function stopSounds():void {
			stopSound();
			soundsAllowed = false;
			expl.stopSounds();
		}
		public function startSounds():void {
			soundsAllowed = true;
			expl.startSounds();
		}
		[Embed(source="../../sounds/knock wood.mp3")]
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
		
		[Embed(source='../../../lib/images.swf', symbol='DelSound')]
        [Bindable]
        public var DestroySndCls:Class;
            
        public var dsnd:Sound = new DestroySndCls() as Sound; 
        public var dsndChannel:SoundChannel;
            
        public function playDestroySnd():void {
			if(soundsAllowed){
				dsndChannel = dsnd.play();
				dsndChannel.soundTransform = new SoundTransform(0.271084);
				dsndChannel.addEventListener(Event.SOUND_COMPLETE, destroy2);
			}else {destroy2();}
        }   
            
    		

		
		public function Tnt5(World:b2World, X:Number = 0, Y:Number = 0, rot:Number = 0) {
			world = World;
			x = X;
			y = Y;
			rotation = rot;
			init();
		
		}
		
		public var destroyed:Boolean;
		public function destroy(e:Event = null):void {
			if(!destroyed){
				world.DestroyBody(dynamicBody);
						
				dynamicBody = null;
				dynamicBodyDefination = null;
				dynamicShapeDefination = null;
				fixtureDef = null;
				if(img)
				if(contains(img)){
					removeChild(img);
					img = null;
				}
				destroyed = true;
			}
			
		}
		
		
		public function destroy2(e:Event=null):void {
			
			//removeChild(img);
			img = null;
		}
		
		
		private function bang(e:MouseEvent):void {
		removeEventListener(MouseEvent.CLICK, bang);	
				
			for (bodiesList = world.GetBodyList(); bodiesList; bodiesList = bodiesList.GetNext()) {
				if (bodiesList.GetType() == b2Body.b2_staticBody) continue;
				if (bodiesList == dynamicBody) continue;
				var pbody:b2Body = bodiesList;
				var bx:Number = pbody.GetWorldCenter().x, by:Number = pbody.GetWorldCenter().y;
				var ax:Number = dynamicBody.GetWorldCenter().x, ay:Number = dynamicBody.GetWorldCenter().y;
				var dx:Number = ax - bx;
				var dy:Number = ay - by;
				var dist:Number = Math.sqrt(dx * dx+dy*dy);
				var ang:Number = Math.atan2(bx - ax, by - ay);
				var F:Number =Parameters.tntForce - dist * .16*.16;
				var fx:Number = F * Math.sin(ang);
				var fy:Number = F * Math.cos(ang);
		
				if (dist >Parameters.tntForceRadius) continue;
				pbody.SetBullet(true);
				
				pbody.SetAwake(true);
				
				pbody.SetFixedRotation(false);
			
				pbody.ApplyImpulse(new b2Vec2(fx, fy), pbody.GetWorldCenter());
			}
			playDestroySnd();			
			addChild(expl);
			removeChild(img);
			expl.animStart();
		}
		
		public function init():void {
			
			
			expl = new Explosion();
			expl.addEventListener(Explosion.EXPLODED, destroy);
			img = new Actor41Img();
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
			fixtureDef.userData = "tnt";
			fixtureDef.shape = dynamicShapeDefination;
			dynamicBody = world.CreateBody(dynamicBodyDefination);
			dynamicBody.CreateFixture(fixtureDef);
			addEventListener(MouseEvent.CLICK, bang);
			
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