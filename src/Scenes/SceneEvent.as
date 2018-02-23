package Scenes
{
import Playtomic.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Potapenkov
	 */
	public dynamic class SceneEvent extends Event {
		public static const LEVEL_FINISHED:String = "levelFinished";
		public static const IN_PAUSE:String = "inPause";
		public static const TO_GAME:String = "toGame";
		public static const LOAD_SCENE:String = "loadScene";
		public static const RELOAD:String = "reload";
		private var sceneToLoad:uint = 1;
		public const minSceneNum:uint = 1;
		public const maxSceneNum:uint = 95;
		
		public function  SceneEvent(type:String):void {
			super(type);
		}
		
		public function get scene():uint {
			return sceneToLoad;
		}
		
		public function set scene(sce:uint) :void {
			if ((sce >= minSceneNum) && (sce <= maxSceneNum)) sceneToLoad = sce;
		}
	}
	
}