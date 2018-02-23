package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class In4 extends Sprite
	{
		[Embed(source='../../lib/images.swf', symbol='in4.png')]
		private var In4Img:Class;
		private var blueImg:Bitmap;
		//private var name:String = "Actor94";
		
		
		
		
		private var movable:Boolean = false;
		
		public function In4() {
			blueImg = new In4Img();
			blueImg.smoothing = true;
			addChild(blueImg);
			x = 430;
			y = 25;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}