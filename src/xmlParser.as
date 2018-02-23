package 
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Potapenkov
	 */
	public class  xmlParser extends MovieClip {
		private var loader:URLLoader;
		private var myxml:XML;
		private var currentLevel:uint = 8;
		
		//[Embed(source = '../lib/images.swf', symbol = 'MyVideo')]
		//private var MyVideo:Class;
		//private var video:MovieClip;
		public function xmlParser() {
			
		//	video = new MyVideo();
		//	trace(video.totalFrames);
			
		//	addChild(video);
			//video.play();
			//loader = new URLLoader();
			//loader.addEventListener(Event.COMPLETE, loadComplete);
			//loadLevel(currentLevel);
		}
		private function loadLevel(i:uint):void{
			trace("-------------------Level " + i + " ---------------------");	
		//	loader.load(new URLRequest("D:/MyDoc/games/Zombie/MyGreatProject.app/Contents/Resources/MyGreatProject.gameproj/scenes/"+i+".xml"));
		}
		
		private function loadComplete(e:Event):void {
			myxml = new XML(loader.data);
			var actors:XMLList = myxml.layers.layer[1].actors.actor;
			var xx:Number;
			var yy:Number;
			var rot:String;
			for each (var tmp:XML in actors) {
				xx = Math.round(Number(tmp.attributes.point.real[0]) * 0.62 - 670);
				yy = Math.round(385 - Number(tmp.attributes.point.real[1]) * 0.54);
				if (tmp.attributes.angle)	rot =";"+ tmp.attributes.angle+";";
				else rot = "";
				trace(tmp.@prototype+";"+xx+";"+yy+rot);
			}
			if(currentLevel<=90)
				loadLevel(currentLevel++);	
		}
		
	}
	
}