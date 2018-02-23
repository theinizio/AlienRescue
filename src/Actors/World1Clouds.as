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
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class World1Clouds extends Sprite
	{
		private var Planets:Vector.<Bitmap> = new Vector.<Bitmap>(13, true);
		private var used:Array = [];
		[Embed(source='../../lib/images.swf', symbol='p01.png')]
		private var Planet1:Class;
		[Embed(source='../../lib/images.swf', symbol='p02.png')]
		private var Planet2:Class;
		[Embed(source='../../lib/images.swf', symbol='p03.png')]
		private var Planet3:Class;
		[Embed(source='../../lib/images.swf', symbol='p04.png')]
		private var Planet4:Class;
		[Embed(source='../../lib/images.swf', symbol='p05.png')]
		private var Planet5:Class;
		[Embed(source='../../lib/images.swf', symbol='p06.png')]
		private var Planet6:Class;
		[Embed(source='../../lib/images.swf', symbol='p07.png')]
		private var Planet7:Class;
		[Embed(source='../../lib/images.swf', symbol='p08.png')]
		private var Planet8:Class;
		[Embed(source='../../lib/images.swf', symbol='p09.png')]
		private var Planet9:Class;
		[Embed(source='../../lib/images.swf', symbol='p10.png')]
		private var Planet10:Class;
		[Embed(source='../../lib/images.swf', symbol='p11.png')]
		private var Planet11:Class;
		[Embed(source='../../lib/images.swf', symbol='p12.png')]
		private var Planet12:Class;
		[Embed(source='../../lib/images.swf', symbol='p13.png')]
		private var Planet13:Class;
		
		private var num:uint;
		
		
		public function World1Clouds() {
			
			Planets[0] = new Planet1();
			Planets[0].smoothing = true;
			Planets[1] = new Planet2();
			Planets[1].smoothing = true;
			Planets[2] = new Planet3();
			Planets[2].smoothing = true;
			Planets[3] = new Planet4();
			Planets[3].smoothing = true;
			Planets[4] = new Planet5();
			Planets[4].smoothing = true;
			Planets[5] = new Planet6();
			Planets[5].smoothing = true;
			Planets[6] = new Planet7();
			Planets[6].smoothing = true;
			Planets[7] = new Planet8();
			Planets[7].smoothing = true;
			Planets[8] = new Planet9();
			Planets[8].smoothing = true;
			Planets[9] = new Planet10();
			Planets[9].smoothing = true;
			Planets[10] = new Planet11();
			Planets[10].smoothing = true;
			Planets[11] = new Planet12();
			Planets[11].smoothing = true;
			Planets[12] = new Planet13();
			Planets[12].smoothing = true;
			
			
			num = 2 + Math.round(Math.random() * 11);
			var tmp:uint;
			for (var i:uint = 0; i < num; i++) {
				tmp = Math.round(Math.random() * 12);
				if (used.indexOf(tmp) == -1) {
					used.push(tmp);
					Planets[tmp].x = Math.round(Math.random() * 640);
					Planets[tmp].y = Math.round(Math.random() * 450);
					if (Math.random()*.2) {
						var scale:Number=.2 + Math.random() * .8;
						Planets[tmp].scaleX = scale;
						Planets[tmp].scaleY = scale;
					}
					var blur:Number = (num - i)*.4;
					Planets[tmp].filters = [new BlurFilter(blur, blur)];
					addChild(Planets[tmp]);
				}
			}
		}
		
		
		
		
		
		
		
		
		
		
		public function destroy():void {
			
			
		}
		
	}
	
}