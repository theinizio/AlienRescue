package Scenes
{
import Playtomic.*;
	import flash.display.MovieClip;
	import Actors.Logo;
	import Actors.World1bg;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Playtomic.*;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public dynamic class  Scene1 extends MovieClip
	{
		private var world1BG:World1bg;
		private var logo:Logo;
		private var world:PhysWorld;
		public function Scene1(World:PhysWorld):void {
			world = World;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		private function init(e:Event = null):void {
			if (world1BG == null) {
				world1BG = new World1bg();
				addChild(world1BG);
			}
			
			
			if (logo == null) {
				logo = new Logo(world);
				//logo.x = 15;
				//logo.y = 15;
				stage.addChild(logo);
				logo.addEventListener(Logo.ANIM_FINISHED, logoClickHandler);
				trace("Making Logo");
			}
		}
		
		private function destroy(e:Event = null):void {
			trace("Scece 1 Stop Sounds");
			world1BG.stopSounds();
			removeChild(world1BG);
			world1BG.destroy();
			world1BG = null;
			trace("Destroying Logo");
			stage.removeChild(logo);
			logo.destroy();
			logo.removeEventListener(Logo.ANIM_FINISHED, logoClickHandler);
			logo = null;
		}
		private function logoClickHandler(evt:Event):void {
			var e:SceneEvent = new SceneEvent(SceneEvent.LOAD_SCENE);
			e.scene = 2;
			dispatchEvent(e);
			Log.Play();
		}
		
	}
	
}