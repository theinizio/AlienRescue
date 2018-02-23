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
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class World1city1 extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="world1city1.png")]
		private var WorldCity1Img:Class;
		private var worldCity1Img:Bitmap;
		//private var name:String = "Actor47";
		
		
		
		private var W:Number = 960;
		public var H:Number = 380;
		
		private var movable:Boolean = false;
		
		public function World1city1() {
			worldCity1Img = new WorldCity1Img();
			worldCity1Img .smoothing = true;
			W = worldCity1Img .width;
			H = worldCity1Img .height;
			addChild(worldCity1Img);
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}