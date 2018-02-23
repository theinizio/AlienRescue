package Actors{
   
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	
	

	public class Twood4 extends SimpleButton {
		
		[Embed (source = "../image/Twood4.png")]
		private var Twood4Up:Class;
		
		
		private var up:Bitmap;
		
	
		
		
		
		
		
		
		
		public function ResetButton9() {
			up   = new Twood4Up();
			up.smoothing = true;
			W = up.width;
			H = up.height;
			
			
			
			downState      = down;
			overState      = down;
			upState        = down;
			hitTestState   = down;
			
			useHandCursor  = true;
			
			
		}
		
	
	}
}


