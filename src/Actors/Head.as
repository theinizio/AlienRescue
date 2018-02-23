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
	public class Head extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="logohead.png")]
		private var HeadImg:Class;
		public var img:Bitmap;
		
		
		private var W:Number;
		private var H:Number;
		
		public var dynamicBody:b2Body;
		private var dynamicBodyDefination:b2BodyDef;
		private var dynamicShapeDefination:b2PolygonShape;
		private var fixtureDef:b2FixtureDef;
		private var world:b2World;
	
		private var physScale:Number =Parameters.physScale;
		private var friction:Number = Parameters.woodFriction;
		private var restitution:Number = Parameters.woodRestitution;
		private var density:Number = Parameters.woodDensity;
		
            
    		

		
		public function Head(World:b2World, X:Number = 0, Y:Number = 0, rot:Number = 0) {
			world = World;
			x = X;
			y = Y;
			rotation = rot;
			init();
		}
		
		public function destroy():void {
			world.DestroyBody(dynamicBody);
						
			dynamicBody = null;
			dynamicBodyDefination = null;
			dynamicShapeDefination = null;
			fixtureDef = null;
			
		}
		
		
		
		
		
		
		
		public function init():void {
			
			img = new HeadImg();
			img.smoothing = true;
			W = img.width;
			H = img.height;
			
			img.x = -W/2;
			img.y = -H/2;
			
			
			
			addChild(img);
			
			
			dynamicBodyDefination = new b2BodyDef();
			dynamicBodyDefination.position.Set(x / physScale, y / physScale);
			dynamicBodyDefination.userData = this;
			dynamicBodyDefination.type = b2Body.b2_staticBody;
			
			dynamicShapeDefination = new b2PolygonShape();
			dynamicShapeDefination.SetAsBox((W-0) / physScale /2, (H-0) / physScale /2);
			fixtureDef = new b2FixtureDef();
			
			fixtureDef.density = 0.02;		// коефициент плотности объекта
			fixtureDef.friction = 0; 		// коефициент трения объекта
			fixtureDef.restitution = 0.8; 	// коефициент упругости
			fixtureDef.userData = "head";
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