package Actors
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class LvlBox
	{
		[Embed (source ="../../lib/images.swf", symbol="lvlbox.png")]
		private var LvlBoxImg:Class;
		public var img:Bitmap;
		
		private var name:String= "Actor88";
		private var W:Number=112;
		private var H:Number=112;
		
		
		
		
		private var lvlNumber:Number=66;
		
		private var physScale:Number = Parameters.physScale;
		//private var friction:Number = 22;
		//private var density:Number = 0.4;
		private var restitution:Number=0;
		//private var drag: Number=8;
		
		public function LvlBox(xx:Number=0, yy:Number=0) {
			X = xx;
			Y = yy;
			
		
		}
		
		
		
		
		
		
		
		
		
		
		public function init(scene:Sprite,world:b2World):void {
			
			
			
			img = new LvlBoxImg();
			img.x = -W/2;
			img.y = -H/2;
			
			
			var imgspr:Sprite = new Sprite();
				imgspr.addChild(img);
			imgspr.x = X;
			imgspr.y = Y;
			scene.addChild(imgspr);
			var dynamicBody:b2Body;
			var dynamicBodyDefination:b2BodyDef;
			var dynamicShapeDefination:b2PolygonShape;
			
			dynamicBodyDefination = new b2BodyDef();
			dynamicBodyDefination.position.Set(X / physScale, Y / physScale);
			dynamicBodyDefination.userData = imgspr;
			dynamicBodyDefination.type = b2Body.b2_dynamicBody;
			
			dynamicShapeDefination = new b2PolygonShape();
			dynamicShapeDefination.SetAsBox((W-0) / physScale /2, (H-0) / physScale /2);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			
			//fixtureDef.density = density;		// коефициент плотности объекта
			fixtureDef.friction = friction; 		// коефициент трения объекта
			fixtureDef.restitution = restitution; 	// коефициент упругости
			fixtureDef.shape = dynamicShapeDefination;
			dynamicBody = world.CreateBody(dynamicBodyDefination);
			dynamicBody.CreateFixture(fixtureDef);
		}
		
		public function getPosition():b2Vec2 {
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
		
		
	}
	
}