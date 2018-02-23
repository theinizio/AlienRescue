package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class World2Text extends Sprite
	{
		//[Embed (source ="../../lib/images.swf", symbol="world2text.png")]
		[Embed(source='../images/world2text.png')]
		private var World2TextImg:Class;
		private var world1TextImg:Bitmap;
		
		
		
	
		
		
		
		public function World2Text() {
			world1TextImg = new World2TextImg();
			world1TextImg.smoothing = true;
			y = 372;
			x = 231;
			addChild(world1TextImg);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}