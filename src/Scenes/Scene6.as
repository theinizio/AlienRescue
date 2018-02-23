package Scenes
{
import Playtomic.*;
	import flash.display.MovieClip;
	import Actors.CompleteButton;
	import Actors.FailButton;
	import Actors.FXButton;
	import Actors.HomeButton;
	import Actors.In1;
	import Actors.In2;
	import Actors.In3;
	import Actors.In4;
	import Actors.LeftArrowButton;
	import Actors.Level;
	import Actors.LevelBox;
	import Actors.Logo;
	import Actors.Met4;
	import Actors.Met5;
	import Actors.MusicButton;
	import Actors.Numbers;
	import Actors.PauseButton;
	import Actors.RefreshButton;
	import Actors.RightArrowButton;
	import Actors.ShocksButton;
	import Actors.WolfSound;
	import Actors.Wood1;
	import Actors.Wood11;
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
	import flash.utils.getTimer;	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public dynamic class  Scene6 extends MovieClip
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
		private var met:Met4;
		private var wood11:Wood11;
		private var wood7:Wood7;
		private var wood9:Wood9;
		private var wood1_1:Wood1;
		private var wood1_2:Wood1;
		private var wood2:Wood2;
		private var wood3:Wood3;
		private var zombie1:Zombie1;
		private var physItems:Vector.<Sprite>;
		
		private var in1:In1;
		private var in1OnScene:Boolean;
		private var in2:In2;
		private var in2OnScene:Boolean;
		private var in3:In3;
		private var in3OnScene:Boolean;
		private var in4:In4;
		private var in4OnScene:Boolean;
			
		private var world:PhysWorld;
		
		private var completeButton:CompleteButton;
		private var failButton:FailButton;
		private var zombieDestroyed:Boolean;
		private var paused:Boolean;
		private var pauseBitmap:Bitmap;
		private var maxLevel:uint;
		private var startTime:uint;
		private var currentLevel:uint = 1;
		
		public function Scene6(World:PhysWorld):void {
						world = World;
			addEventListener(Event.ADDED_TO_STAGE,init);
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
			//pauseButton.stopSounds();
			homeButton.stopSounds();
			shocksButton.stopSounds();
			wood1_1.stopSounds();
			wood1_2.stopSounds();
			wood11.stopSounds();
			wood7.stopSounds();
			wood9.stopSounds();
			wood2.stopSounds();
			wood3.stopSounds();
			zombie1.stopSounds() ;
		}


		
		
		public function startSounds():void {
			failButton.startSounds();
			completeButton.startSounds();
			world1BG.startSounds();
			refreshButton.startSounds();
			leftArrowButton.startSounds();
			rightArrowButton.startSounds();
			//pauseButton.startSounds();
			homeButton.startSounds();
			shocksButton.startSounds();
			wood1_1.startSounds();
			wood1_2.startSounds();
			wood11.startSounds();
			wood7.startSounds();
			wood9.startSounds();
			wood2.startSounds();
			wood3.startSounds();
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
				//pauseButton.disable();
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
			if(stage.hasEventListener(MouseEvent.CLICK))stage.removeEventListener(MouseEvent.CLICK, inPauseClick, true);
			destroy();
			init();
		}
		private function init(e:Event = null):void {
		//	world = new PhysWorld();
		//	addChild(world);
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
			
			numbers2 = new Numbers(1);
			numbers2.x = 407;
			numbers2.y = 438;
			addChild(numbers2);
			
			leftArrowButton = new LeftArrowButton();
			leftArrowButton.disable();
			addChild(leftArrowButton);
			
			rightArrowButton = new RightArrowButton();
			if(maxLevel<=currentLevel)rightArrowButton.disable();
			addChild(rightArrowButton);
			rightArrowButton.addEventListener(MouseEvent.CLICK, nextLevel);
			
			homeButton = new HomeButton();
			homeButton.addEventListener(MouseEvent.CLICK, loadMenu);
			addChild(homeButton);
			
			shocksButton = new ShocksButton();
			shocksButton.disable();
			addChild(shocksButton);
			shocksButton.addEventListener(MouseEvent.CLICK, burnIt);
				
			//pauseButton = new PauseButton();
			////addChild(pauseButton);
			//pauseButton.addEventListener(MouseEvent.CLICK, pauseFunc);
			
			completeButton = new CompleteButton();
			completeButton.addEventListener(MouseEvent.CLICK, nextLevel);
			
			failButton = new FailButton();
			failButton.addEventListener(MouseEvent.CLICK, reloadScene);
			
			met= new Met4(world.world, 298, 322);
			addChild(met);
			physItems.push(met);
			
			wood11= new Wood11(world.world, 318, 287);
			addChild(wood11);
			wood11.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood11);
			
			wood1_1 = new Wood1(world.world, 377, 322);
			addChild(wood1_1);
			wood1_1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood1_1);
			
			
			
			wood9 = new Wood9(world.world, 298, 253);
			addChild(wood9);
			wood9.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood9);
			
			
			wood2 = new Wood2(world.world, 377, 253);
			addChild(wood2);
			wood2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood2);
			
			wood7 = new Wood7(world.world,278, 218);
			addChild(wood7);
			wood7.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood7);
			
			zombie1 = new Zombie1(world.world, 276, 179);
			addChild(zombie1);
			physItems.push(zombie1);
			zombie1.addEventListener(Zombie1.EXPLODED, exploded);
			zombieDestroyed = false;
			
			wood1_2 = new Wood1(world.world, 337, 218);
			addChild(wood1_2);
			wood1_2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood1_2);
			
			wood3 = new Wood3(world.world, 377, 218);
			addChild(wood3);
			wood3.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood3);
			
			
			pauseBitmap = new Bitmap();
			pauseBitmap.bitmapData = new BitmapData(630, 420, true, 0x88000000);
			pauseBitmap.addEventListener(MouseEvent.CLICK, inPauseClick, true, 1, false);
			refreshButton.addEventListener(MouseEvent.CLICK, reloadScene);
			rightArrowButton.addEventListener(MouseEvent.CLICK, nextLevel);
			homeButton.addEventListener(MouseEvent.CLICK, loadMenu);
			in1 = new In1();
			in1.name = "in1";
				addChild(in1);
				in1OnScene = true;
			in2 = new In2();
		
			in3 = new In3();
		
			in4 = new In4();
			
			if (!soundsAllowed) stopSounds();
			startTime=getTimer();
			
		}
		
		private function loadMenu(evt:MouseEvent):void {
			if (paused) {
				removeChild(pauseBitmap);
				stage.removeEventListener(MouseEvent.CLICK, inPauseClick, true);
				paused = false;
			}
			var e:SceneEvent = new SceneEvent(SceneEvent.LOAD_SCENE);
			if (maxLevel > 30) e.scene = 2;
			else e.scene = 2;
			dispatchEvent(e);
		}
		
		private function removeElement(e:MouseEvent):void {
		
			if(in1OnScene){		
				removeChild(in1);
				addChild(in2);
				in1OnScene = false;
				in2OnScene = true;
			}
			
			e.target.destroy();
			removeChild(e.target as DisplayObject);
			e.target.removeEventListener(MouseEvent.CLICK, removeElement);
			physItems.splice(physItems.indexOf(e.target), 1);
			if ((zombie1.y >= 255) && (in2OnScene)) {
				in2OnScene = false;
				removeChild(in2);
				
			}
			if ((world.world.GetBodyCount() > 4) && (zombie1.y > 255)) {
				addChild(in3);
				in3OnScene = true;
			}
			if ((zombie1.y > 255) && (world.world.GetBodyCount() == 4)) {
				addChild(in4);
				in4OnScene = true;
				if (in3OnScene) {
					removeChild(in3);
					in3OnScene = false;
				}
			}
			trace(world.contactListener.groundContact, world.contactListener.metContact);
		}
		
		
		
		
		private function burnIt(e:MouseEvent):void {
			shocksButton.animStop(); shocksButton.enabled = false; shocksButton.mouseEnabled = false;
			if (in4OnScene) {
				removeChild(in4);
				in4OnScene = true;
			}
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
		
		private function nextLevel(e:MouseEvent):void {
			if (stage.hasEventListener(MouseEvent.CLICK))
				stage.removeEventListener(MouseEvent.CLICK, inPauseClick, true);
			var event:SceneEvent = new SceneEvent(SceneEvent.LOAD_SCENE);
			event.scene = 7;
			dispatchEvent(event);
		}
		
		public function destroy(e:Event=null):void {
			 in1 = null;
			 in2 = null;
			in3 = null;
			in4 = null;
			
			homeButton.removeEventListener(MouseEvent.CLICK, loadMenu);
			//pauseButton.removeEventListener(MouseEvent.CLICK, pauseFunc);
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
			removeChild(leftArrowButton);
			leftArrowButton = null;
			removeChild(rightArrowButton);
			rightArrowButton.removeEventListener(MouseEvent.CLICK, nextLevel);
			rightArrowButton = null;
			removeChild(homeButton);
			homeButton = null;
			if (shocksButton.enabled) shocksButton.removeEventListener(MouseEvent.CLICK, burnIt);
			removeChild(shocksButton);
			shocksButton = null;
			////removeChild(pauseButton);
			//pauseButton = null;
			if (paused) removeChild(pauseBitmap);
			//if(pauseBitmap.bitmapData!=null)pauseBitmap.bitmapData = null;
		//	pauseBitmap = null;
			if (getChildByName("completeButton")) removeChild(completeButton);
			completeButton.removeEventListener(MouseEvent.CLICK, nextLevel);
			completeButton = null;
			
			if (getChildByName("failButton")) removeChild(failButton);
			failButton.removeEventListener(MouseEvent.CLICK, reloadScene);
			failButton = null;
			
			//world.destroyWorld();
			
		}
		
		
	}
	
}


