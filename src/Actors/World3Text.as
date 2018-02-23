package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class World3Text extends Sprite
	{
		//[Embed (source ="../../lib/images.swf", symbol="world3text.png")]
		[Embed(source='../images/world3text.png')]
		private var World3TextImg:Class;
		private var world1TextImg:Bitmap;
		
		
		public function World3Text() {
			world1TextImg = new World3TextImg();
			world1TextImg.smoothing = true;
			y = 372;
			x = 231;
			addChild(world1TextImg);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}