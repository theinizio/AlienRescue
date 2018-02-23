package Scenes
{
import Playtomic.*;
	import flash.display.MovieClip;
	import Actors.Bub3;
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
	import Actors.Met8;
	import Actors.MusicButton;
	import Actors.Numbers;
	import Actors.PauseButton;
	import Actors.RefreshButton;
	import Actors.RightArrowButton;
	import Actors.ShocksButton;
	import Actors.Tire1;
	import Actors.Tire3;
	import Actors.Tire5;
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
	import flash.utils.getTimer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public dynamic class  Scene13 extends MovieClip
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
		
		private var met1:Met7;
		
		private var bub1:Bub3;
		private var wood1:Wood2;
		private var wood2:Wood11;
		private var wood3:Wood7;
		private var wood4:Wood9;
		private var wood5:Wood1;
		private var wood6:Wood3;
		
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
		private var currentLevel:uint = 8;
		
		
		public function Scene13(World:PhysWorld):void {
			world = World;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private var soundsAllowed:Boolean = true;
		public function setVars(max:uint, fx:Boolean):void {
			maxLevel = max;
			if (!fx) {
				soundsAllowed = false;		
			}else soundsAllowed = true;
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
			wood6.stopSounds();
			//wood7.stopSounds();
			
			bub1.stopSounds();
			
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
			wood6.startSounds();
			//wood7.startSounds();
			
			
			bub1.startSounds();
			
			zombie1.startSounds();
			
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
		
		private function init(e:Event=null):void {
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
			
			numbers2 = new Numbers(8);
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
			
			met1= new Met7(world.world, 422, 322);
			addChild(met1);
			physItems.push(met1);
			
			wood1 = new Wood2(world.world, 363, 287);
			addChild(wood1);
			wood1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood1);
			
			wood2 = new Wood11(world.world, 223, 322);
			addChild(wood2);
			wood2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood2);


			bub1 = new Bub3(world.world, 183, 287);
			addChild(bub1);
			bub1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub1);
			
			wood3 = new Wood7(world.world, 233, 287);
			addChild(wood3);
			wood3.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood3);
			
			wood4 = new Wood9(world.world, 222, 253);
			addChild(wood4);
			wood4.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood4);
			
			wood5 = new Wood1(world.world, 222, 218);
			addChild(wood5);
			wood5.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood5);
			
			wood6 = new Wood3(world.world, 222, 184);
			addChild(wood6);
			wood6.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood6);
			/*
			wood7 = new Wood3(world.world, 385, 184);
			addChild(wood7);
			wood7.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood7);
			*/
			
			
			zombie1 = new Zombie1(world.world, 224, 145);
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
			startTime=getTimer();
		}
		private function loadScene(evt:MouseEvent):void {
			
			
			var newScene:uint = 3;
			switch(evt.target) {
				case homeButton: { newScene = 2; break; }
				case leftArrowButton: { newScene = 12; break; }
				case completeButton:
				case rightArrowButton: { newScene = 14; break; }
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
			world.contactListener.metToAnimate.animStart();
			//met2.animStart();
		}
		
		private function exploded(e:Event):void {
						 Log.LevelCounterMetric("Complete", "Level"+currentLevel);
			var event:SceneEvent = new SceneEvent(SceneEvent.LEVEL_FINISHED);
			event.scene = currentLevel+5;
			dispatchEvent(event);
			world.contactListener.metToAnimate.animStop();
			//met2.animStop();
			addChild(completeButton);
			rightArrowButton.enable();
		}
		
		private function everyFrameFunction(e:Event):void {
			if ((zombie1.y > 335)) fail();
			for (var i:uint = 0; i <physItems.length; i++) {
				var tmp:* = physItems[i];
				if (tmp == zombie1) continue;
				if ((tmp.y < -00)||(tmp.y>400)) {
					tmp.destroy();
					removeChild(tmp as DisplayObject);
					if(tmp.hasEventListener(MouseEvent.CLICK))tmp.removeEventListener(MouseEvent.CLICK, removeElement);
					physItems[i] = null;
					physItems.splice(i, 1);
				}
			}
		}
		
		public function destroy(e:Event=null):void {
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
			leftArrowButton.stopSound();
			removeChild(leftArrowButton);
			leftArrowButton = null;
			removeChild(rightArrowButton);
			rightArrowButton.removeEventListener(MouseEvent.CLICK, loadScene);
			rightArrowButton.stopSound();
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


