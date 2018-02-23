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
	public class Level extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="level.png")]
		private var LevelImg:Class;
		private var levelImg:Bitmap;
		
		
		
		
		private var W:Number = 200;
		private var H:Number = 64;
		
		private var movable:Boolean = false;
		
		public function Level() {
			levelImg = new LevelImg();
			levelImg.smoothing = true;
			
			addChild(levelImg);
			x = 235;
			y = 432;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}