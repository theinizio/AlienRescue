package Scenes
{
import com.spilgames.api.AwardsService;
import Playtomic.*;
	import flash.display.MovieClip;
	
	import Actors.last.*;
	import Actors.LeftArrowButton;
	import Actors.Level;
	import Actors.Numbers;
	import Actors.PauseButton;
	import Actors.RefreshButton;
	import Actors.RightArrowButton;
	import Actors.ShocksButton;
	import Actors.World3bg;
	import Actors.Zombie3;
	import Actors.CompleteGameButton;
	import Actors.FailButton;
	import Actors.HomeButton;
	
	import flash.utils.getTimer;
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
	public dynamic class  Scene95 extends MovieClip
	{
		private var world1BG:World3bg;
		private var refreshButton:RefreshButton ;
		private var level:Level;
		private var numbers1:Numbers ;
		private var numbers2:Numbers ;
		private var leftArrowButton:LeftArrowButton ;
		private var rightArrowButton:RightArrowButton;
		private var homeButton:HomeButton;
		public  var shocksButton:ShocksButton;
		private var pauseButton:PauseButton;
		
		private var met1:Met1;		
		//private var met2:Met1;
		//private var met3:Met3;
		
		private var bub1:Bub4;
		private var bub2:Bub3;
		private var bub3:Bub2;
		private var bub4:Bub1;
		
		private var tire1:Tire1;
		private var tire2:Tire2;
		private var tire3:Tire3;
		private var tire4:Tire6;
		private var tire5:Tire4;
		private var tire6:Tire5;
		
		private var tnt1:Tnt7;
		private var tnt2:Tnt1;
		private var tnt3:Tnt8;
		private var tnt4:Tnt4;
		private var tnt5:Tnt5;
		private var tnt6:Tnt6;
		private var tnt7:Tnt3;
		
		private var wood1:Wood4;
		private var wood2:Wood12;
		private var wood3:Wood4;
		private var wood4:Wood9;
		private var wood5:Wood8;
		private var wood6:Wood10;
		private var wood7:Wood2;
		private var wood8:Wood5;
		private var wood9:Wood11;
		private var wood10:Wood7;
		//private var wood11:Wood11;
		//private var wood12:Wood9;
		//private var wood13:Wood4;
		//private var wood14:Wood7;
		//private var wood15:Wood7;
		//private var wood16:Wood11;
		
		private var zombie1:Zombie3;
		
		private var physItems:Vector.<Sprite>;
		private var world:PhysWorld;
		private var completeButton:CompleteGameButton;
		private var failButton:FailButton;
		private var zombieDestroyed:Boolean;
		private var paused:Boolean;
		private var pauseBitmap:Bitmap;
		private var maxLevel:uint;
		private var startTime:uint;
		private var currentLevel:uint = 90;
		public var spr:Sprite;
		
		public function Scene95(World:PhysWorld):void {
			world = World;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
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
			wood7.stopSounds();
			wood8.stopSounds();
			wood9.stopSounds();
			wood10.stopSounds();
			//wood11.stopSounds();
		//	wood12.stopSounds();
			//wood13.stopSounds();
			//wood14.stopSounds();
			//wood15.stopSounds();
		//	wood16.stopSounds();
			
			tire1.stopSounds();
			tire2.stopSounds();
			tire3.stopSounds();
			tire4.stopSounds();
			tire5.stopSounds();
			tire6.stopSounds();
			
			tnt1.stopSounds();
			tnt2.stopSounds();
			tnt3.stopSounds();
			tnt4.stopSounds();
			tnt5.stopSounds();
			tnt6.stopSounds();
			tnt7.stopSounds();
			
			bub1.stopSounds();
			bub2.stopSounds();
			bub3.stopSounds();
			bub4.stopSounds();
			
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
			wood7.startSounds();
			wood8.startSounds();
			wood9.startSounds();
			wood10.startSounds();
			//wood11.startSounds();
			//wood12.startSounds();
			//wood13.startSounds();
			//wood14.startSounds();
			//wood15.startSounds();
			//wood16.startSounds();
			
			tire1.startSounds();
			tire2.startSounds();
			tire3.startSounds();
			tire4.startSounds();
			tire5.startSounds();
			tire6.startSounds();
			
			tnt1.startSounds();
			tnt2.startSounds();
			tnt3.startSounds();
			tnt4.startSounds();
			tnt5.startSounds();
			tnt6.startSounds();
			tnt7.startSounds();
			
			bub1.startSounds();
			bub2.startSounds();
			bub3.startSounds();
			bub4.startSounds();
			
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
			
			//addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveFunction);
			
			physItems = new Vector.<Sprite>();
			world1BG = new World3bg();
			addChild(world1BG);
			
			refreshButton = new RefreshButton();
			addChild(refreshButton);
			
			level = new Level();
			addChild(level);
			
			numbers1 = new Numbers(Math.floor(currentLevel/10));
			numbers1.x = 376;
			numbers1.y = 438;
			addChild(numbers1);
			
			numbers2 = new Numbers(currentLevel%10);
			numbers2.x = 407;
			numbers2.y = 438;
			addChild(numbers2);
			
			leftArrowButton = new LeftArrowButton();
			addChild(leftArrowButton);
			
			rightArrowButton = new RightArrowButton();
			
				rightArrowButton.disable();
			//addChild(rightArrowButton);
			
			homeButton = new HomeButton();
			addChild(homeButton);
			
			shocksButton = new ShocksButton();
			shocksButton.disable();
			addChild(shocksButton);
			shocksButton.addEventListener(MouseEvent.CLICK, burnIt);
				
			pauseButton = new PauseButton();
			//addChild(pauseButton);
			pauseButton.addEventListener(MouseEvent.CLICK, pauseFunc);
			
			completeButton = new CompleteGameButton();
			completeButton.addEventListener(MouseEvent.CLICK, loadScene);
			
			failButton = new FailButton();
			failButton.addEventListener(MouseEvent.CLICK, reloadScene);
			
			
			
			met1 = new Met1(world.world, 298, 258);
			//met1.setRotation(1.5 * Math.PI);
			addChild(met1);
			physItems.push(met1);
			
			bub1 = new Bub4(world.world, 218, 78);
			//bub1.setRotation(1.5 * Math.PI);
			addChild(bub1);
			bub1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub1);
			
			
			bub2 = new Bub3(world.world, 234, 244);
			//bub2.setRotation(1.5 * Math.PI);
			addChild(bub2);
			bub2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub2);
			
			bub3 = new Bub2(world.world, 378, 134);
			addChild(bub3);
			bub3.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub3);
			
			bub4 = new Bub1(world.world, 520, 258);
			addChild(bub4);
			bub4.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub4);
			
			
			tire1 = new Tire1(world.world, 66, 258);
			//tire1.setRotation(1.5 * Math.PI);
			addChild(tire1);
			tire1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire1);
			
			tnt1 = new Tnt7(world.world, 155, 258);
			//tnt1.setRotation(.5 * Math.PI);
			addChild(tnt1);
			 
			tire2 = new Tire2(world.world, 123, 217);
			//tire2.setRotation(.5 * Math.PI);
			addChild(tire2);
			tire2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire2);
			
			
			wood1 = new Wood4(world.world, 187, 217);	
			//wood1.setRotation(1.5 * Math.PI);
			addChild(wood1);
			wood1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood1);
			
			tnt2 = new Tnt1(world.world, 234, 202);
			//tnt2.setRotation(1.5 * Math.PI);
			addChild(tnt2);
			
			wood2 = new Wood12(world.world, 218, 161);
			//wood2.setRotation(-.25 * Math.PI);
			addChild(wood2);
			wood2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood2);
			
			wood3 = new Wood4(world.world, 123, 106);
			//wood3.setRotation(1.5 * Math.PI);
			addChild(wood3);
			wood3.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood3);
			
			tire3 = new Tire3(world.world, 123, 64);
			//tire3.setRotation(.5 * Math.PI);
			addChild(tire3);
			tire3.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire3);
			
			tnt3 = new Tnt8(world.world, 218, 23);
			//tnt3.setRotation(1.5 * Math.PI);
			addChild(tnt3);
			
			tire4 = new Tire6(world.world, 441, 23);
			addChild(tire4);
			tire4.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire4);
			
			tnt4 = new Tnt4(world.world, 473, 78);
			//tnt4.setRotation(1.5 * Math.PI);
			addChild(tnt4);
			
			tire5 = new Tire4(world.world, 473, 134);
			addChild(tire5);
			tire5.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire5);
			
			tnt5 = new Tnt5(world.world, 298, 120);
			//tnt5.setRotation(1.5 * Math.PI);
			addChild(tnt5);
			
			wood4 = new Wood9(world.world, 202, 120);
			//wood4.setRotation(1.5 * Math.PI);
			addChild(wood4);
			wood4.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood4);
			
			wood5 = new Wood8(world.world, 346, 78);
			//wood5.setRotation(1.5 * Math.PI);
			addChild(wood5);
			wood5.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood5);
			
			wood6 = new Wood10(world.world, 461, 189);
			//wood6.setRotation(1.5 * Math.PI);
			addChild(wood6);
			wood6.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood6);
			
			wood7 = new Wood2(world.world, 520, 230);
			//wood7.setRotation(1.5 * Math.PI);
			addChild(wood7);
			wood7.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood7);
			
			tnt6 = new Tnt6(world.world, 409, 244);
			addChild(tnt6);
			
			tnt7 = new Tnt3(world.world, 282, 230);
			addChild(tnt7);
			
			tire6 = new Tire5(world.world, 298, 202);
			addChild(tire6);
			tire6.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire6);
			
			wood8 = new Wood5(world.world, 378, -33);
			//wood8.setRotation(1.5 * Math.PI);
			addChild(wood8);
			wood8.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood8);
			
			wood9 = new Wood11(world.world, 282, -18);
			//wood9.setRotation(3/180 * Math.PI);
			addChild(wood9);
			wood9.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood9);
			
			
			wood10 = new Wood7(world.world, 250, -46);
			//wood10.setRotation(.5 * Math.PI);
			addChild(wood10);
			wood10.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood10);
			
			zombie1 = new Zombie3(world.world, 314, -50);
			addChild(zombie1);
			physItems.push(zombie1);
			zombie1.addEventListener(Zombie3.EXPLODED, exploded);
			zombieDestroyed = false;
			
			pauseBitmap = new Bitmap();
			pauseBitmap.bitmapData = new BitmapData(630, 420, true, 0x88000000);
			pauseBitmap.addEventListener(MouseEvent.CLICK, inPauseClick,true,1,false);refreshButton.addEventListener(MouseEvent.CLICK, reloadScene);leftArrowButton.addEventListener(MouseEvent.CLICK, loadScene);rightArrowButton.addEventListener(MouseEvent.CLICK, loadScene);	spr = new Sprite();homeButton.addEventListener(MouseEvent.CLICK, loadScene);				spr.name = "spr";
			addChild(spr);
			addEventListener(Event.ENTER_FRAME, everyFrameFunction);
			if (!soundsAllowed) stopSounds();	
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
				case leftArrowButton: { newScene = currentLevel+4; break; }
				case completeButton:{ newScene = 2; break; }
				case rightArrowButton: { newScene = currentLevel+6; break; }
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
			trace(e.target);
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
			//AwardsService.submitAward("award3");
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
		
		public function destroy(e:Event = null):void {
			//removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveFunction);
			removeEventListener(Event.ENTER_FRAME, everyFrameFunction);
			homeButton.removeEventListener(MouseEvent.CLICK, loadScene);
			pauseButton.removeEventListener(MouseEvent.CLICK, pauseFunc);
			refreshButton.removeEventListener(MouseEvent.CLICK, reloadScene);
			removeChild(spr);
			spr = null;
		
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
			//removeChild(rightArrowButton);
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
			tnt1.destroy();
			tnt1 = null;
			tnt2.destroy();
			tnt2 = null;
			tnt3.destroy();
			tnt3 = null;
			tnt4.destroy();
			tnt4 = null;
			tnt5.destroy();
			tnt5 = null;
			tnt6.destroy();
			tnt6 = null;
			tnt7.destroy();
			tnt7 = null;
		}
		
		
	}
	
}


