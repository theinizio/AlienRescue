package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class In2 extends Sprite
	{
		[Embed(source='../../lib/images.swf', symbol='in2.png')]
		private var In2Img:Class;
		private var blueImg:Bitmap;
		//private var name:String = "Actor46";
		
		
		
		
		private var movable:Boolean = false;
		
		public function In2() {
			blueImg = new In2Img();
			blueImg.smoothing = true;
			addChild(blueImg);
			x = 135;
			y = 287;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}