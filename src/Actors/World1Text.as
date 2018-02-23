package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class World1Text extends Sprite
	{
		//[Embed (source ="../../lib/images.swf", symbol="world1text.png")]
		[Embed(source='../images/world1text.png')]
		private var World1TextImg:Class;
		private var world1TextImg:Bitmap;
		
		
		public function World1Text() {
			world1TextImg = new World1TextImg();
			world1TextImg.smoothing = true;
			y = 372;
			x = 231;
			addChild(world1TextImg);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}