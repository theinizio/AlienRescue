package Scenes
{
import Playtomic.*;
	import flash.display.MovieClip;
	import Actors.FXButton;
	import Actors.HomeButton;
	import Actors.Level;
	import Actors.LevelBox;
	import Actors.Logo;
	import Actors.MusicButton;
	import Actors.PauseButton;
	import Actors.WolfSound;
	import Actors.World1bg;
	import Actors.World1Button;
	import Actors.World2bg;
	import Actors.World2Button;
	import Actors.World2Text;
	import Actors.World3Button;
	import Actors.Zombie1;
	import Actors.Zombie2;
	import Box2D.Collision.b2Manifold;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public dynamic class  Scene4 extends MovieClip
	{
		private var world1BG:World2bg;
		private var b1:PauseButton;
		private var b2:HomeButton;
		private var boxes:Vector.<LevelBox>;
		private var zombie:Zombie2;
		private var maxLevel:uint=1;
		private var e:SceneEvent ;
		
		// Physics world
		public var world:b2World;
	
		private var groundDefination :b2BodyDef;
		private var groundShape:b2PolygonShape;
		private var blinking:int;

		private var text:World2Text;
		
		public function Scene4(World:b2World, max:uint):void {
			world = World;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			maxLevel = max;	
		}
		private var soundsAllowed:Boolean = true;
		public function setVars(max:uint, fx:Boolean):void {
			maxLevel = max;
			if (!fx) {
				soundsAllowed = false;
				
			}else soundsAllowed = true;
		}
		public function stopSounds():void {
			world1BG.stopSounds();
		}
		
		public function startSounds():void {
			world1BG.startSounds();
		}
			
		private function init(e:Event=null):void{
			world1BG = new World2bg();
			addChild(world1BG);
			//text = new World2Text();
			//addChild(text);
			b1 = new PauseButton();
			//addChild(b1);
			b2 = new HomeButton();
			addChild(b2);
			b2.addEventListener(MouseEvent.CLICK, loadMainMenu);
			
			boxes = new Vector.<LevelBox>(30, true);
			var tmpBox:LevelBox;
			var lvlNum:uint;
			//trace("Scene4 max "+maxLevel);
			for (var i:int = 59; i >= 30; i--) {
				if (i < maxLevel) lvlNum = i+1;
				else lvlNum = 0;
				tmpBox = new LevelBox(world, (i % 8) * 80 + 50, (i % 4) * 80 - 10, 0, lvlNum);
				if(lvlNum!=0)tmpBox.addEventListener(MouseEvent.CLICK, loadScene);
				addChild(tmpBox);	
				boxes[i-30] = tmpBox;
			}
			zombie = new Zombie2(world, 335, 0);
			addChild(zombie);
			if(maxLevel<60)
				blinking = maxLevel - 30;
			else blinking = boxes.length - 1;
			boxes[blinking].startBlink();
			if (!soundsAllowed) stopSounds();	
			tmpBox = null;
		}
		
		
		private function loadScene(evt:MouseEvent):void {
			e = new SceneEvent(SceneEvent.LOAD_SCENE);
			//trace(evt.target.level);
			e.scene = evt.target.level+5;
			dispatchEvent(e);
		}
		
		private function loadMainMenu(evt:MouseEvent):void {
			e= new SceneEvent(SceneEvent.LOAD_SCENE);
			e.scene = 2;
			dispatchEvent(e);
		}
		
		public function destroy(e:Event = null):void {
			//removeChild(text);
			//text = null;
			world1BG.destroy();
			world1BG = null;
			//removeChild(b1);
			removeChild(b2);
			b1 = null;
			b2 = null;
			boxes[1].removeEventListener(MouseEvent.CLICK, loadScene);
			boxes[1].stopBlink();
			var tmp:Object;
			for (var i:uint = 0; i < 30; i++) {
				boxes[i].destroy();
				
				removeChild(boxes[i] as DisplayObject);
				boxes[i] = null;
			}
			zombie.destroy();
			removeChild(zombie);
			zombie = null;
		}
		
		
	}
	
}