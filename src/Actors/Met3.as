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
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Met3 extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="met3.png")]
		private var Actor31aImg:Class;
		public var imga:Bitmap;
		[Embed (source ="../../lib/images.swf", symbol="met3b.png")]
		private var Actor31bImg:Class;
		public var imgb:Bitmap;
		[Embed (source ="../../lib/images.swf", symbol="met3c.png")]
		private var Actor31cImg:Class;
		public var imgc:Bitmap;
		
		//private var name:String= "Actor30";
		private var W:Number = 128;
		private var H:Number = 64;
		
		
		
	
		
		
		
		
		
		
		private var physScale:Number = Parameters.physScale;
		private var friction:Number = Parameters.metFriction;
		private var density:Number = Parameters.metDensity;
		private var restitution:Number=Parameters.metRestitution;
		private var drag: Number=8;
		private var imgspr:Sprite;
		private var animTimer:Timer;
		private var dynamicBody:b2Body;
		private var dynamicBodyDefination:b2BodyDef;
		private var dynamicShapeDefination:b2PolygonShape;
		private var fixtureDef:b2FixtureDef;
		private var world:b2World;
		
		
		public function Met3(World:b2World, X:Number = 0, Y:Number = 0, Rotation:Number = 0) {
			world = World;
			x = X;
			y = Y;
			rotation = Rotation;
			init();
		}
		
		public function destroy():void {
			animTimer.stop();
			animTimer.removeEventListener(TimerEvent.TIMER, animate);
			animTimer = null;
			removeChild(imga); imga = null;
			removeChild(imgb); imgb = null;
			removeChild(imgc); imgc = null;
			world.DestroyBody(dynamicBody);
			dynamicBody = null;
			dynamicBodyDefination = null;
			dynamicShapeDefination = null;
			fixtureDef = null;
			
		}
		
		
		
		
		
		
		
		
		
		public function init():void {
			animTimer = new Timer(150);
			animTimer.addEventListener(TimerEvent.TIMER, animate);
			
			imga = new Actor31aImg();
			W = imga.width;
			H = imga.height;
			
			imga.x = -W/2;
			imga.y = -H/2;
			imgb = new Actor31bImg();
			imgb.x = -W/2;
			imgb.y = -H / 2;
			imgb.visible = false;
			imgc = new Actor31cImg();
			imgc.x = -W/2;
			imgc.y = -H/2;
			imgc.visible = false;
			
			
			addChild(imga);
			addChild(imgb);
			addChild(imgc);
			
			
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
			fixtureDef.shape = dynamicShapeDefination;
			fixtureDef.userData = "met";
			dynamicBody = world.CreateBody(dynamicBodyDefination);
			dynamicBody.CreateFixture(fixtureDef);
		}
		
	
		
		public function setPosition(vec:b2Vec2):void {
			x = vec.x;
			x = vec.y;
			dynamicBody.SetPosition(vec);
		}
		
		public function getRotation():Number {
			return this.rotation;
		}
		public function setRotation(rot:Number):void {
			dynamicBody.SetAngle(rot);
			rotation = rot;
		}
		public function animStart():void {
			animTimer.start();
		}
		public function animStop():void {
			animTimer.stop();
		}
		
		private function animate(e:TimerEvent):void {
			switch(uint(animTimer.currentCount % 3)) {
				case 0: {
							imga.visible = true;
							imgb.visible = false;
							imgc.visible = false;
							break;
				}
				case 1: {
							imga.visible = false;
							imgb.visible = true;
							imgc.visible = false;
							break;
				}
				case 2: {
							imga.visible = false;
							imgb.visible = false;
							imgc.visible = true;
							break;
				}
			}
			
		}
		
	}
	
}