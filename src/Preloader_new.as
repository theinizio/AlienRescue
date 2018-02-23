package 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Potapenkov
	 */
	public class Preloader extends MovieClip 
	{
		[Embed(source = "../lib/jockerman.ttf", fontFamily = "Jockerman", embedAsCFF = "false")]
		public var JockermanFont:String;
		
		
		[Embed(source='../lib/images.swf', symbol='loader_bg.png')]
		private var BG:Class;
		private var bg:Bitmap;
		
		private var tf:TextField;
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			
			// TODO show loader
			bg = new BG();
			bg.smoothing = true;
			bg.x = 94;
			bg.y = 13;
			addChild(bg);
			
			tf = new TextField();
			tf.y = 232;
			tf.x = 195;
			tf.textColor = 0x7FB334;
			tf.embedFonts = true;
			tf.selectable = false;
			var tff:TextFormat = new TextFormat();
			tff.font = "Jockerman";
			tff.size = 16;
			tff.color=0x7FB334;
			tf.defaultTextFormat = tff;
			tf.text = "Hello!";
			addChild(tf);
			
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
			var amount:uint = Math.round(e.bytesLoaded / e.bytesTotal * 100);
			tf.text = amount + "%";
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
			
		}
		
		private function loadingFinished():void 
		{
			
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			
			removeChild(tf);
			tf = null;
			removeChild(bg);
			bg = null;
			startup();
			
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}