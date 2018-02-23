package Actors
{
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.media.*;
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class World1bg extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="world1bg.jpg")]
		private var BlueImg:Class;
		private var blueImg:Bitmap;
		[Embed (source ="../../lib/images.swf", symbol="world1sides2.png")]
		private var World1SidesImg:Class;
		private var world1SidesImg:Bitmap;
		private var asteroid:Asteroid;
		private var clouds:World1Clouds;
		
		
		public function World1bg() {
			blueImg = new BlueImg();
			blueImg.smoothing = true;
			addChild(blueImg);
			
			clouds= new World1Clouds();
			addChild(clouds);
			
			asteroid = new Asteroid();
			addChild(asteroid);
			world1SidesImg = new World1SidesImg();
			world1SidesImg.y += 320;
			world1SidesImg .smoothing = true;
			addChild(world1SidesImg);		
		}
		public function stopSounds():void {
					}
		
		public function startSounds():void {
			
		}
		public function destroy():void {
			stopSounds();
			removeChild(blueImg);
			blueImg = null;
			removeChild(world1SidesImg);
			world1SidesImg = null;
			removeChild(clouds);
			clouds.destroy();
			clouds = null;
			removeChild(asteroid);
			asteroid.destroy();
			asteroid = null;
		}
		
		
		
		
		
		
		
		
		
		
		
	}
	
}