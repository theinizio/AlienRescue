package Scenes
{
import Playtomic.*;
	import flash.display.MovieClip;
	import Actors.CompleteButton;
	import Actors.FailButton;
	import Actors.FXButton;
	import Actors.HomeButton;
	import Actors.LeftArrowButton;
	import Actors.Level;
	import Actors.LevelBox;
	import Actors.Logo;
	import Actors.Met3;
	import Actors.Met4;
	import Actors.Met5;
	import Actors.Met7;
	import Actors.MusicButton;
	import Actors.Numbers;
	import Actors.PauseButton;
	import Actors.RefreshButton;
	import Actors.RightArrowButton;
	import Actors.ShocksButton;
	import Actors.Tire1;
	import Actors.Tire3;
	import Actors.WolfSound;
	import Actors.Wood1;
	import Actors.Wood11;
	import Actors.Wood4;
	
	import Actors.Wood2;
	import Actors.Wood3;
	import Actors.Wood7;
	import Actors.Wood9;
	import Actors.World1bg;
	import Actors.World1Button;
	import Actors.World2Button;
	import Actors.World3Button;
	import Actors.Zombie1;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.ui.Mouse;
	
	import Box2D.Dynamics.b2World;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public dynamic class  Scene9 extends MovieClip
	{
		private var world1BG:World1bg;
		private var refreshButton:RefreshButton ;
		private var level:Level;
		private var numbers1:Numbers ;
		private var numbers2:Numbers ;
		private var leftArrowButton:LeftArrowButton ;
		private var rightArrowButton:RightArrowButton;
		private var homeButton:HomeButton;
		public  var shocksButton:ShocksButton;
		private var pauseButton:PauseButton;
		private var met:Met3;
		private var wood1:Wood1;
		private var wood2:Wood7;
		private var tire1:Tire3;
		private var wood3:Wood9;
		private var wood4:Wood2;
		private var tire2:Tire1;
		private var wood5:Wood3;
		
		
		[Embed(source='../../lib/images.swf', symbol='in6.png')]
		private var IN6:Class;
		private var in6:Bitmap;
		private var in6OnScene:Boolean;
		
		
		private var zombie1:Zombie1;
		private var physItems:Vector.<Sprite>;
		private var world:PhysWorld;
		private var completeButton:CompleteButton;
		private var failButton:FailButton;
		private var zombieDestroyed:Boolean;
		private var paused:Boolean;
		private var pauseBitmap:Bitmap;
		private var maxLevel:uint;
		private var startTime:uint;
		private var currentLevel:uint = 4;
		
		
		public function Scene9(World:PhysWorld):void {
			world = World;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		public function stopSounds():void {
			completeButton.stopSounds();
			failButton.stopSounds();
			world1BG.stopSounds();
			refreshButton.stopSounds();
			leftArrowButton.stopSounds();
			rightArrowButton.stopSounds();
			pauseButton.stopSounds();
			homeButton.stopSounds();
			shocksButton.stopSounds();
			wood1.stopSounds();
			wood2.stopSounds();
			wood3.stopSounds();
			wood4.stopSounds();
			wood5.stopSounds();
			tire1.stopSounds();
			tire2.stopSounds();
			zombie1.stopSounds();
		}


		
		
		public function startSounds():void {
			completeButton.startSounds();
			failButton.startSounds();
			world1BG.startSounds();
			refreshButton.startSounds();
			leftArrowButton.startSounds();
			rightArrowButton.startSounds();
			pauseButton.startSounds();
			homeButton.startSounds();
			shocksButton.startSounds();
			wood1.startSounds();
			wood2.startSounds();
			wood3.startSounds();
			wood4.startSounds();
			wood5.startSounds();
			tire1.startSounds();
			tire2.startSounds();
			zombie1.startSounds();
			
		}


		
		
		private function addedToStageHandler(e:Event):void {
			init();
		}
		
		private function removedFromStageHandler(e:Event):void {
			destroy();
		}
		
		


		private function inPauseClick(e:MouseEvent):void {
			if ((e.target == pauseButton) || (e.target == homeButton) || (e.target == refreshButton)||(e.target == failButton)) return;
			e.stopPropagation();
			e.stopImmediatePropagation();
			
		}
		
		
		public function fail():void {
			
			 Log.LevelCounterMetric("Fail", "Level"+currentLevel);
			
				
				addChild(failButton);
				refreshButton.animStart();
				pauseButton.disable();
				stage.addEventListener(MouseEvent.CLICK, inPauseClick, true);
			
		}
		
		
		public function readyToBurn():void {
			shocksButton.enable();
			
			shocksButton.animStart();
		}
		
		private function reloadScene(e:MouseEvent):void {
			 Log.LevelCounterMetric("Restart", "Level"+currentLevel);
			
			if (paused) {
				removeChild(pauseBitmap);
				paused = false;
			}
			if (stage.hasEventListener(MouseEvent.CLICK))
				stage.removeEventListener(MouseEvent.CLICK, inPauseClick, true);
			destroy();
			init();
		}
		
		private function init():void {
			Log.LevelCounterMetric("EnterLevel", "Level"+currentLevel);
Log.LevelCounterMetric("EnterLevel", "Level"+currentLevel);
			
			
			physItems = new Vector.<Sprite>();
			world1BG = new World1bg();
			addChild(world1BG);
			
			refreshButton = new RefreshButton();
			addChild(refreshButton);
			
			level = new Level();
			addChild(level);
			
			numbers1 = new Numbers(0);
			numbers1.x = 376;
			numbers1.y = 438;
			addChild(numbers1);
			
			numbers2 = new Numbers(4);
			numbers2.x = 407;
			numbers2.y = 438;
			addChild(numbers2);
			
			leftArrowButton = new LeftArrowButton();
			addChild(leftArrowButton);
			
			rightArrowButton = new RightArrowButton();
			if(maxLevel<=currentLevel)
				rightArrowButton.disable();
			addChild(rightArrowButton);
			
			homeButton = new HomeButton();
			addChild(homeButton);
			
			shocksButton = new ShocksButton();
			shocksButton.disable();
			addChild(shocksButton);
			shocksButton.addEventListener(MouseEvent.CLICK, burnIt);
				
			pauseButton = new PauseButton();
			//addChild(pauseButton);
			pauseButton.addEventListener(MouseEvent.CLICK, pauseFunc);
			
			completeButton = new CompleteButton();
			completeButton.addEventListener(MouseEvent.CLICK, loadScene);
			
			failButton = new FailButton();
			failButton.addEventListener(MouseEvent.CLICK, reloadScene);
			
			met= new Met3(world.world, 341, 322);
			addChild(met);
			physItems.push(met);
			
			wood1 = new Wood1(world.world, 254, 322);
			addChild(wood1);
			wood1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood1);
			
			wood2 = new Wood7(world.world, 283, 287);
			addChild(wood2);
			wood2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood2);
			
			tire1 = new Tire3(world.world, 362, 287);
			addChild(tire1);
			tire1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire1);
			
			wood3 = new Wood9(world.world, 332, 253);
			addChild(wood3);
			wood3.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood3);
			
			wood4 = new Wood2(world.world, 376, 218);
			addChild(wood4);
			wood4.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood4);
			
			tire2 = new Tire1(world.world, 335, 218);
			addChild(tire2);
			tire2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire2);
			
			wood5 = new Wood3(world.world, 336, 184);
			addChild(wood5);
			wood5.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood5);
			
			zombie1 = new Zombie1(world.world, 340, 145);
			addChild(zombie1);
			physItems.push(zombie1);
			zombie1.addEventListener(Zombie1.EXPLODED, exploded);
			zombieDestroyed = false;
			
			pauseBitmap = new Bitmap();
			pauseBitmap.bitmapData = new BitmapData(630, 420, true, 0x88000000);
			pauseBitmap.addEventListener(MouseEvent.CLICK, inPauseClick,true,1,false);refreshButton.addEventListener(MouseEvent.CLICK, reloadScene);leftArrowButton.addEventListener(MouseEvent.CLICK, loadScene);rightArrowButton.addEventListener(MouseEvent.CLICK, loadScene);
			addEventListener(Event.ENTER_FRAME, everyFrameFunction);
			homeButton.addEventListener(MouseEvent.CLICK, loadScene);
			if (!soundsAllowed) stopSounds();	
			
			
			in6 = new IN6();
			in6.x = 404;
			in6.y = 281;
			addChild(in6);
			in6OnScene = true;
		}
		
		private var soundsAllowed:Boolean = true;
		public function setVars(max:uint, fx:Boolean):void {
			maxLevel = max;
			if (!fx) {
				soundsAllowed = false;		
			}else soundsAllowed = true;
		}
		private function loadScene(evt:MouseEvent):void {
			
			
			var newScene:uint = 3;
			switch(evt.target) {
				case homeButton: { newScene = 2; break; }
				case leftArrowButton: { newScene = 8; break; }
				case completeButton:
				case rightArrowButton: { newScene = 10; break; }
			}
			
			//if(stage!=null)
				if (stage.hasEventListener(MouseEvent.CLICK))
					stage.removeEventListener(MouseEvent.CLICK, inPauseClick, true);
			
			if (paused) {
				removeChild(pauseBitmap);
				paused = false;
			}
			var e:SceneEvent = new SceneEvent(SceneEvent.LOAD_SCENE);
			e.scene = newScene;
			dispatchEvent(e);	
			
		}
		
		private function removeElement(e:MouseEvent):void {
			if (in6OnScene) {
				in6OnScene = false;
				removeChild(in6);
			}
			
			e.target.removeEventListener(MouseEvent.CLICK, removeElement);
			
			e.target.destroy();
			removeChild(e.target as DisplayObject);
			physItems.splice(physItems.indexOf(e.target), 1);
			
		}
		
		
		public function pauseFunc(E:MouseEvent):void {
			trace("PauseFunc");
			if (paused) {
				removeChild(pauseBitmap);
				stage.removeEventListener(MouseEvent.CLICK, inPauseClick,true);
			}
			else {
				addChild(pauseBitmap);
				//addChild(pauseButton);
				addChild(homeButton);
				addChild(refreshButton);
				stage.addEventListener(MouseEvent.CLICK, inPauseClick,true);
			}
			paused = !paused;
		}
		
		private function burnIt(e:MouseEvent):void { 
			shocksButton.animStop(); shocksButton.enabled = false; shocksButton.mouseEnabled = false;
			
			zombie1.explode();
			met.animStart();
		}
		
		private function exploded(e:Event):void {
						 Log.LevelCounterMetric("Complete", "Level"+currentLevel);
			var event:SceneEvent = new SceneEvent(SceneEvent.LEVEL_FINISHED);
			event.scene = currentLevel+5;
			dispatchEvent(event);
			met.animStop();
			addChild(completeButton);
			rightArrowButton.enable();
		}
		
		private function everyFrameFunction(e:Event):void {
			if (zombie1.y > 335) fail();
		}
		
		public function destroy():void {
			removeEventListener(Event.ENTER_FRAME, everyFrameFunction);
			homeButton.removeEventListener(MouseEvent.CLICK, loadScene);
			pauseButton.removeEventListener(MouseEvent.CLICK, pauseFunc);
			refreshButton.removeEventListener(MouseEvent.CLICK, reloadScene);
			
		
			for (var i:uint = 0; i <physItems.length; i++) {
				var tmp:* = physItems[i];
				tmp.destroy();
				removeChild(tmp as DisplayObject);
				if(tmp.hasEventListener(MouseEvent.CLICK))tmp.removeEventListener(MouseEvent.CLICK, removeElement);
				physItems[i] = null;
			}
			
			physItems = null;
			world1BG.destroy();
			removeChild(world1BG);
			world1BG = null;
			
			refreshButton.animStop();
			removeChild(refreshButton);
			refreshButton = null;
			removeChild(level);
			level = null;
			removeChild(numbers1);
			numbers1 = null;
			removeChild(numbers2);
			numbers2 = null;
			leftArrowButton.removeEventListener(MouseEvent.CLICK, loadScene);
			removeChild(leftArrowButton);
			leftArrowButton = null;
			removeChild(rightArrowButton);
			rightArrowButton.removeEventListener(MouseEvent.CLICK, loadScene);
			rightArrowButton = null;
			removeChild(homeButton);
			homeButton = null;
			if (shocksButton.enabled) shocksButton.removeEventListener(MouseEvent.CLICK, burnIt);
			removeChild(shocksButton);
			shocksButton = null;
			//removeChild(pauseButton);
			pauseButton = null;
			if (paused) removeChild(pauseBitmap);
			//if(pauseBitmap.bitmapData!=null)pauseBitmap.bitmapData = null;
			pauseBitmap = null;
			if (getChildByName("completeButton")) removeChild(completeButton);
			completeButton.removeEventListener(MouseEvent.CLICK, loadScene);
			completeButton = null;
			
			if (getChildByName("failButton")) removeChild(failButton);
			failButton.removeEventListener(MouseEvent.CLICK, reloadScene);
			failButton = null;
			
			
		}
		
		
	}
	
}


