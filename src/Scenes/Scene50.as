package Scenes
{
import Playtomic.*;
	import flash.display.MovieClip;
	
	import Actors.*;
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
	public dynamic class  Scene50 extends MovieClip
	{
		private var world1BG:World2bg;
		private var refreshButton:RefreshButton ;
		private var level:Level;
		private var numbers1:Numbers ;
		private var numbers2:Numbers ;
		private var leftArrowButton:LeftArrowButton ;
		private var rightArrowButton:RightArrowButton;
		private var homeButton:HomeButton;
		public  var shocksButton:ShocksButton;
		private var pauseButton:PauseButton;
		
		private var met1:Met3;
		//private var met2:Met3;
		//private var met3:Met3;
		
		private var bub1:Bub1;
		private var bub2:Bub1;
		//private var bub3:Bub1;
		//private var bub4:Bub1;
		
		private var tire1:Tire1;
		private var tire2:Tire1;
		//private var tire3:Tire3
		//private var tire4:Tire1;
		//private var tire5:Tire1;
		//private var tire6:Tire1;
		
		private var tnt1:Tnt1;
		private var tnt2:Tnt1;
		private var tnt3:Tnt1;
		private var tnt4:Tnt1;
		private var tnt5:Tnt1;
		
		private var wood1:Wood7;
		private var wood2:Wood11;
		private var wood3:Wood1;
		private var wood4:Wood11;
		private var wood5:Wood9;
		private var wood6:Wood9;
		private var wood7:Wood11;
		private var wood8:Wood1;
		private var wood9:Wood7;
		private var wood10:Wood7;
		private var wood11:Wood11;
		private var wood12:Wood11;
		//private var wood13:Wood1;
		//private var wood14:Wood7;
		//private var wood15:Wood7;
	//	private var wood16:Wood11;
		
		private var zombie1:Zombie2;
		
		private var physItems:Vector.<Sprite>;
		private var world:PhysWorld;
		private var completeButton:CompleteButton;
		private var failButton:FailButton;
		private var zombieDestroyed:Boolean;
		private var paused:Boolean;
		private var pauseBitmap:Bitmap;
		private var maxLevel:uint;
		private var startTime:uint;
		private var currentLevel:uint = 45;
		public var spr:Sprite;
		
		public function Scene50(World:PhysWorld):void {
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
			wood11.stopSounds();
			wood12.stopSounds();
			//wood13.stopSounds();
			//wood14.stopSounds();
			//wood15.stopSounds();
		//	wood16.stopSounds();
			
			tire1.stopSounds();
			tire2.stopSounds();
			//tire3.stopSounds();
			//tire4.stopSounds();
			//tire5.stopSounds();
			//tire6.stopSounds();
			
			tnt1.stopSounds();
			tnt2.stopSounds();
			tnt3.stopSounds();
			tnt4.stopSounds();
			tnt5.stopSounds();
			
			bub1.stopSounds();
			bub2.stopSounds();
			//bub3.stopSounds();
			//bub4.stopSounds();
			
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
			wood11.startSounds();
			wood12.startSounds();
			//wood13.startSounds();
			//wood14.startSounds();
			//wood15.startSounds();
			//wood16.startSounds();
			
			tire1.startSounds();
			tire2.startSounds();
			//tire3.startSounds();
			//tire4.startSounds();
			//tire5.startSounds();
			//tire6.startSounds();
			
			tnt1.startSounds();
			tnt2.startSounds();
			tnt3.startSounds();
			tnt4.startSounds();
			tnt5.startSounds();
			
			bub1.startSounds();
			bub2.startSounds();
			//bub3.startSounds();
			//bub4.startSounds();
			
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
			world1BG = new World2bg();
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
			
			
			met1= new Met3(world.world, 249, 322);
			addChild(met1);
			physItems.push(met1);
			/*
			met2= new Met3(world.world, 382, 114);
			addChild(met2);
			physItems.push(met2);
			
			met3= new Met3(world.world, 182, 114);
			addChild(met3);
			physItems.push(met3);
			*/
			bub1 = new Bub1(world.world, 217, 253);
			addChild(bub1);
			bub1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub1);
			
			
			bub2 = new Bub1(world.world, 419, 253);
			addChild(bub2);
			bub2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub2);
			/*
			bub3 = new Bub1(world.world, 382, 253);
			addChild(bub3);
			bub3.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub3);
			
			bub4 = new Bub1(world.world, 355, 322);
			addChild(bub4);
			bub4.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub4);
			*/
			
			tnt1 = new Tnt1(world.world, 318, 218);
			addChild(tnt1);
			
			wood1 = new Wood7(world.world, 319, 253);	
			//wood1.setRotation(.25 * Math.PI);
			addChild(wood1);
			wood1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood1);
			
			wood2 = new Wood11(world.world, 240, 287);
			//wood2.setRotation(.5 * Math.PI);
			addChild(wood2);
			wood2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood2);
			
			wood3 = new Wood1(world.world, 318, 322);
			//wood3.setRotation(0.5 * Math.PI);
			addChild(wood3);
			wood3.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood3);
			/*
			tire4 = new Tire1(world.world, 334, 322);
			addChild(tire4);
			tire4.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire4);
			
			tire5 = new Tire1(world.world, 386, 322);
			addChild(tire5);
			tire5.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire5);
			*/
			wood4 = new Wood11(world.world, 399, 287);
			//wood4.setRotation(.5 * Math.PI);
			addChild(wood4);
			wood4.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood4);
			
			tnt2 = new Tnt1(world.world, 458, 322);
			//tnt2.setRotation(1.5 * Math.PI);
			addChild(tnt2);
				
			tnt3 = new Tnt1(world.world, 180, 322);
			//tnt3.setRotation(1.5 * Math.PI);
			addChild(tnt3);
			
			wood5 = new Wood9(world.world, 235, 218);
			//wood5.setRotation(.5 * Math.PI);
			addChild(wood5);
			wood5.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood5);
			
			wood6 = new Wood9(world.world, 401, 218);
			//wood6.setRotation(1.5 * Math.PI);
			addChild(wood6);
			wood6.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood6);
			
			wood7 = new Wood11(world.world, 318, 149);
			//wood7.setRotation(1.5 * Math.PI);
			addChild(wood7);
			wood7.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood7);
			
			tire1 = new Tire1(world.world, 258, 184);
			//tire1.setRotation(1.5 * Math.PI);
			addChild(tire1);
			tire1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire1);
			
			tire2 = new Tire1(world.world, 377, 184);
			addChild(tire2);
			tire2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire2);
			/*
			tire3 = new Tire3(world.world, 283, 184);
			addChild(tire3);
			tire3.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire3);
			
			
			
			
			bub2 = new Bub1(world.world, 331, 183);
			addChild(bub2);
			bub2.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub2);
			*//*
			
			bub1 = new Bub3(world.world, 283, 252);
			addChild(bub1);
			bub1.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(bub1);
			*/
			
			
			wood8 = new Wood1(world.world, 317, 114);
			//wood8.setRotation(0.5 * Math.PI);
			addChild(wood8);
			wood8.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood8);
			
			tnt4 = new Tnt1(world.world, 244, 114);
			addChild(tnt4);
			
			tnt5 = new Tnt1(world.world, 394, 114);
			addChild(tnt5);
			
			wood9 = new Wood7(world.world, 250, 80);
			//wood9.setRotation(1.5 * Math.PI);
			addChild(wood9);
			wood9.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood9);
			/*
			tire6 = new Tire3(world.world, 281, 114);
			addChild(tire6);
			tire6.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(tire6);
			
			*/
			
			
			wood10 = new Wood7(world.world, 384, 80);
			
			addChild(wood10);
			wood10.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood10);
			
			wood11 = new Wood11(world.world, 191, 132);
			wood11.setRotation(1.5 * Math.PI);
			addChild(wood11);
			wood11.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood11);
			
			wood12 = new Wood11(world.world, 444, 132);
			wood12.setRotation(1.5 * Math.PI);
			addChild(wood12);
			wood12.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood12);
			/*
			wood13 = new Wood1(world.world, 144, 148);
			addChild(wood13);
			wood13.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood13);
			
			wood14 = new Wood7(world.world, 184, 114);
			addChild(wood14);
			wood14.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood14);
			
			wood15 = new Wood7(world.world, 382, 114);
			addChild(wood15);
			wood15.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood15);
			
			wood16 = new Wood11(world.world, 283, 79);
			addChild(wood16);
			wood16.addEventListener(MouseEvent.CLICK, removeElement);
			physItems.push(wood16);
			*/
			zombie1 = new Zombie2(world.world, 317, 76);
			addChild(zombie1);
			physItems.push(zombie1);
			zombie1.addEventListener(Zombie1.EXPLODED, exploded);
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
				case completeButton:
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
		}
		
		
	}
	
}


