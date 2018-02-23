package Actors
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Zombie1 extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="zombie2b.png")]
		private var Actor1Img:Class;
		public var img:Bitmap;
		
		//private var name:String= "Actor 1";
		private var W:Number=88;
		private var H:Number=80;
		
		private var physScale:Number = Parameters.physScale;
		
		private var density:Number = 0.4;
		private var restitution:Number=0;
		private var drag: Number=8;
		private var dynamicBody:b2Body;
		
		public function Zombie1(xx:Number=0, yy:Number=0, rot:Number=0) {
			X = xx;
			Y = yy;
			rotation = rot;
			trace("X=" + X + " Y=" + Y);
		}
		
		
		
		
		private var World:b2World;
		private var Stage:Sprite;
		private var imgspr:Sprite;
		
		
		
		public function init(scene:Sprite,world:b2World):void {
			
			World = world;
			Stage = scene;
			img = new Actor1Img();
			img.x = -W/2;
			img.y = -H/2;
			
			
			imgspr = new Sprite();
				imgspr.addChild(img);
			imgspr.x = X;
			imgspr.y = Y;
			scene.addChild(imgspr);
			
			var dynamicBodyDefination:b2BodyDef;
			var dynamicShapeDefination:b2PolygonShape;
			
			dynamicBodyDefination = new b2BodyDef();
			dynamicBodyDefination.position.Set(X / physScale, Y / physScale);
			dynamicBodyDefination.userData = imgspr;
			dynamicBodyDefination.type = b2Body.b2_dynamicBody;
			
			dynamicShapeDefination = new b2PolygonShape();
			dynamicShapeDefination.SetAsBox((W-0) / physScale /2, (H-0) / physScale /2);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			
			fixtureDef.density = density;		// коефициент плотности объекта
			//fixtureDef.friction = friction; 		// коефициент трения объекта
			fixtureDef.restitution = restitution; 	// коефициент упругостиефициент упругости
			fixtureDef.shape = dynamicShapeDefination;
			dynamicBody = world.CreateBody(dynamicBodyDefination);
			dynamicBody.CreateFixture(fixtureDef);
		}
		
		public function getPosition():b2Vec2 {
			
			X = imgspr.x-img.width;
			Y = imgspr.y-img.height;
			trace("X=" + X, "Y=" + Y);
			return new b2Vec2(X, Y);
		}
		
		public function setPosition(vec:b2Vec2):void {
			X = vec.x;
			Y = vec.y;
		}
		
		public function getRotation():Number {
			return rotation;
		}
		public function setRotation(rot:Number):void {
			rotation = rot;
		}
		public function remove():void {
			World.DestroyBody(dynamicBody);
			Stage.removeChild(imgspr);
		}
		
	}
	
}