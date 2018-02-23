package Actors
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class Asteroid extends Sprite
	{
		
		[Embed(source = '../../lib/images.swf', symbol = 'asteroid.png')]
		private var AsteroidImg:Class;
		private var asteroid:Bitmap;
		
		private var startY:int = -150;
		private var animTimer:Timer;
		private var periodicTimer:Timer;
		public function Asteroid() {
			animTimer = new Timer(1, 800);
			animTimer.addEventListener(TimerEvent.TIMER, animation);
			animTimer.addEventListener(TimerEvent.TIMER_COMPLETE, animTimerCompleteHandler);
			
			asteroid = new AsteroidImg();
			
			periodicTimer = new Timer(7000);
			periodicTimer.addEventListener(TimerEvent.TIMER, periodicTimerHandler);
			periodicTimer.start();
			
		}
		
		private function periodicTimerHandler(e:TimerEvent):void 
		{
			if (Math.random()) 
			{
				asteroid.x = Math.random() * 800;
				asteroid.y = startY;
				addChild(asteroid);
				animTimer.reset();
				animTimer.start();
			}
		}
		
		private function animTimerCompleteHandler(e:TimerEvent):void 
		{
			removeChild(asteroid);
		}
		
		private function animation(e:TimerEvent):void 
		{
			asteroid.x -= 6;
			asteroid.y += asteroid.height / asteroid.width*6;
		}
		

		public function destroy():void {
			
			animTimer.stop();
			periodicTimer.stop();
			animTimer = null;
			periodicTimer = null;
			if (contains(asteroid)) removeChild(asteroid);
			asteroid = null;
		}
		
	}
	
}