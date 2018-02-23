package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class In3 extends Sprite
	{
		[Embed(source='../../lib/images.swf', symbol='in3.png')]
		private var In3Img:Class;
		private var blueImg:Bitmap;
		//private var name:String = "Actor46";
		
		
		
		
		private var movable:Boolean = false;
		
		public function In3() {
			blueImg = new In3Img();
			blueImg.smoothing = true;
			addChild(blueImg);
			x = 395;
			y = 270;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}