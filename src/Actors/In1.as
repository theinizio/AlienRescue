package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class In1 extends Sprite
	{
		[Embed(source='../../lib/images.swf', symbol='in1.png')]
		private var In1Img:Class;
		private var blueImg:Bitmap;
		//private var name:String = "Actor46";
		
		
		
		
		private var movable:Boolean = false;
		
		public function In1() {
			blueImg = new In1Img();
			blueImg.smoothing = true;
			addChild(blueImg);
			x =  135;
			y = 165;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}