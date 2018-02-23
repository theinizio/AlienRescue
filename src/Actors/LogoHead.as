package Actors
{
	
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.*;
	
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class LogoHead extends Sprite
	{
		[Embed (source ="../../lib/images.swf", symbol="logohead.png")]
		private var LogoHeadImg:Class;
		private var logoHeadImg:Bitmap;
			
		private var W:Number =120;
		private var H:Number = 140;
		
		private var movable:Boolean = false;
		
		[Embed(source="../sounds/thud.mp3")]
        [Bindable]
        public var PopSndCls:Class;
            
        public var snd:Sound = new PopSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
        public function playSnd(e:MouseEvent = null):void {
			
            sndChannel=snd.play();
        }   
            
        public function stopSound():void {
            sndChannel.stop();
        }
		
		
		
		
		
		
		
		public function LogoHead() {
			logoHeadImg = new LogoHeadImg();
			addChild(logoHeadImg);
			addEventListener(MouseEvent.CLICK, playSnd);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}