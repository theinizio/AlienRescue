package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class World2Hills extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="world2hills.png")]
		private var World2HillsImg:Class;
		private var world2HillsImg:Bitmap;
		private var name:String = "Actor84";
		
		
		
		private var W:Number = 960;
		private var H:Number = 640;
		
		private var movable:Boolean = false;
		
		public function World2Hills() {
			world2HillsImg = new World2HillsImg();
			addChild(world2HillsImg);
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}