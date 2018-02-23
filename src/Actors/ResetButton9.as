package Actors{
   
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

	public class ResetButton9 extends Sprite{
		
		public static const RESET:String = "reset";
		public static const CANCEL:String = "cancel";
		
		[Embed(source='../../lib/images.swf', symbol='newbutton5.png')]
		private var ResetButton9Up:Class;
		
		
		private var up:Bitmap;
	
		private var reset:SimpleButton;
		private var cancel:SimpleButton;
		
		
		
		
		
		
		public function ResetButton9() {
			up   = new ResetButton9Up();
			up.smoothing = true;
			x = (640 - up.width) / 2;
			y = (480 - up.height) / 2;
			addChild(up);
			var bitmap:Bitmap = new Bitmap();
			bitmap.bitmapData = new BitmapData(139, 78, true, 0x000000);
			
			reset = new SimpleButton(bitmap, bitmap, bitmap, bitmap);
			reset.x = 25;
			reset.y = 76;
			reset.addEventListener(MouseEvent.CLICK, resetHandler);
			addChild(reset);
			
			cancel = new SimpleButton(bitmap, bitmap, bitmap, bitmap);
			cancel.x = 209;
			cancel.y = 76;
			cancel.addEventListener(MouseEvent.CLICK, cancelHandler);
			addChild(cancel);
		}
		
		private function cancelHandler(e:MouseEvent):void 
		{
			dispatchEvent( new Event(CANCEL));
		}
		
		private function resetHandler(e:MouseEvent):void 
		{
			dispatchEvent(new Event(RESET));
		}
		public function destroy():void {
			reset.removeEventListener(MouseEvent.CLICK, resetHandler);
			removeChild(reset);
			reset = null;
			
			cancel.removeEventListener(MouseEvent.CLICK, cancelHandler);
			removeChild(cancel);
			cancel = null;
		
			removeChild(up);
			up = null;
		}
	}
}


