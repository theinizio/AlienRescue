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
	public class Charge extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="charge.png")]
		private var ChargeImg:Class;
		private var chargeImg:Bitmap;
		private var alfa:Number = 0.25;
		
		
		
		private var W:Number = 78;
		private var H:Number = 32;
		
		private var movable:Boolean = false;
		
		public function Charge() {
			chargeImg = new ChargeImg();
			W = chargeImg.width;
			H = chargeImg.height;
			chargeImg.smoothing = true;
			//chargeImg.alpha = alfa;
			addChild(chargeImg);
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}