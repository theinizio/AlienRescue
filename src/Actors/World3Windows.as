package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class World3Windows extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="World3Windows.png")]
		private var World3WindowsImg:Class;
		private var world3WindowsImg:Bitmap;
		private var name:String = "Actor84";
		
		
		
		private var W:Number = 960;
		private var H:Number = 640;
		
		private var movable:Boolean = false;
		
		public function World3Windows() {
			world3WindowsImg = new World3WindowsImg();
			addChild(world3WindowsImg);
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}