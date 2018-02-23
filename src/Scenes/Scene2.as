package Scenes
{
import Playtomic.*;
	import flash.display.MovieClip;
	import Actors.FXButton;
	import Actors.Logo;
	import Actors.MusicButton;
	import Actors.ResetButton;
	import Actors.ResetButton9;
	import Actors.WolfSound;
	import Actors.World1bg;
	import Actors.World1Button;
	import Actors.World2Button;
	import Actors.World3Button;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Actors.YellowStarButton;
	import Actors.RedStarButton;
	import Actors.GreenStarButton;
	import flash.filters.GlowFilter;
	import Playtomic.*;
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public dynamic class  Scene2 extends MovieClip
	{
		
		public static const MUSIC_ON: String = "musicOn";
		public static const MUSIC_OFF:String = "musicOff";
		public static const FX_ON: String = "fxOn";
		public static const FX_OFF:String = "fxOff";
		[Embed(source = '../../lib/images.swf', symbol = 'in5.png')]
		private var IN5:Class;
		private var in5:Bitmap;
		private var in5OnScene:Boolean;
		
		[Embed(source='../../lib/images.swf', symbol='level_select.jpg')]
		private var BG:Class;
		private var bg:Bitmap;
		private var musicBtn:MusicButton;
		private var fxBtn:FXButton;
		
		private var maxLevel:uint = 1;
		private var linesSpr:Sprite;
		private var starsSpr:Sprite;
		
		private var yellowStars:Vector.<YellowStarButton>;
		private var greenStars:Vector.<GreenStarButton>;
		private var redStars:Vector.<RedStarButton>;
		private var lineThickness:uint = 1;
		private var redColor:int = 0XEB0000;
		private var greenColor:int = 0X0BEB00;
		private var yellowColor:int = 0xFFE431;
		
		private var yellowCoords:Vector.<b2Vec2>;
		private var greenCoords:Vector.<b2Vec2>;
		private var redCoords:Vector.<b2Vec2>;
		
		private var resetBtn:ResetButton;
		public var resetBitmap:ResetButton9=new ResetButton9();
		
		private var startTime:uint;
		
		public var soundsAllowed:Boolean = true;
		public var musicAllowed:Boolean = true;
		
		
		
		
		
		
		
		public function Scene2():void {
		
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(e:Event = null):void {
			in5 = new IN5();
			in5.x = 105;
			in5.y = 293;
			
			Log.LevelCounterMetric("Menu", "menu");
			bg = new BG();
			addChild(bg);
			linesSpr = new Sprite();
			linesSpr.filters = [new GlowFilter(0xFFFFFF, 0.8, 2, 2, 1)];
			addChild(linesSpr);
			
			starsSpr = new Sprite();
			addChild(starsSpr);
			
			yellowStars = new Vector.<YellowStarButton>(30, true);
			redStars = new Vector.<RedStarButton>(30, true);
			greenStars = new Vector.<GreenStarButton>(30, true);
			yellowCoords = new Vector.<b2Vec2>(30, true);
			greenCoords = new Vector.<b2Vec2>(30, true);
			redCoords = new Vector.<b2Vec2>(30, true);
			yellowCoords[0] = new b2Vec2(233, 300);
			yellowCoords[1] = new b2Vec2(247, 280);
			yellowCoords[2] = new b2Vec2(269, 266);
			yellowCoords[3] = new b2Vec2(311, 244);
			yellowCoords[4] = new b2Vec2(347, 238);
			yellowCoords[5] = new b2Vec2(382, 222);
			yellowCoords[6] = new b2Vec2(416, 195);
			yellowCoords[7] = new b2Vec2(423, 229);
			yellowCoords[8] = new b2Vec2(428, 256);
			yellowCoords[9] = new b2Vec2(455, 270);
			yellowCoords[10] = new b2Vec2(473, 290);
			yellowCoords[11] = new b2Vec2(521, 305);
			yellowCoords[12] = new b2Vec2(583, 266);
			yellowCoords[13] = new b2Vec2(570, 300);
			yellowCoords[14] = new b2Vec2(559, 329);
			yellowCoords[15] = new b2Vec2(559, 354);
			yellowCoords[16] = new b2Vec2(587, 401);
			yellowCoords[17] = new b2Vec2(541, 381);
			yellowCoords[18] = new b2Vec2(498, 358);
			yellowCoords[19] = new b2Vec2(451, 357);
			yellowCoords[20] = new b2Vec2(410, 380);
			yellowCoords[21] = new b2Vec2(400, 398);
			yellowCoords[22] = new b2Vec2(408, 427);
			yellowCoords[23] = new b2Vec2(363, 406);
			yellowCoords[24] = new b2Vec2(341, 389);
			yellowCoords[25] = new b2Vec2(314, 379);
			yellowCoords[26] = new b2Vec2(275, 361);
			yellowCoords[27] = new b2Vec2(233, 333);
			yellowCoords[28] = new b2Vec2(266, 323);
			yellowCoords[29] = new b2Vec2(289, 303);
			
			greenCoords[0] = new b2Vec2(204, 47);
			greenCoords[1] = new b2Vec2(231, 80);
			greenCoords[2] = new b2Vec2(265, 103);
			greenCoords[3] = new b2Vec2(302, 120);
			greenCoords[4] = new b2Vec2(293, 139);
			greenCoords[5] = new b2Vec2(268, 140);
			greenCoords[6] = new b2Vec2(240, 141);
			greenCoords[7] = new b2Vec2(234, 203);
			greenCoords[8] = new b2Vec2(237, 265);
			greenCoords[9] = new b2Vec2(240, 318);
			greenCoords[10] = new b2Vec2(257, 426);
			greenCoords[11] = new b2Vec2(229, 431);
			greenCoords[12] = new b2Vec2(209, 345);
			greenCoords[13] = new b2Vec2(187, 352);
			greenCoords[14] = new b2Vec2(187, 432);
			greenCoords[15] = new b2Vec2(166, 437);
			greenCoords[16] = new b2Vec2(158, 363);
			greenCoords[17] = new b2Vec2(119, 368);
			greenCoords[18] = new b2Vec2(124, 439);
			greenCoords[19] = new b2Vec2(106, 440);
			greenCoords[20] = new b2Vec2(87, 375);
			greenCoords[21] = new b2Vec2(84, 441);
			greenCoords[22] = new b2Vec2(67, 440);
			greenCoords[23] = new b2Vec2(62, 328);
			greenCoords[24] = new b2Vec2(23, 347);
			greenCoords[25] = new b2Vec2(102, 285);
			greenCoords[26] = new b2Vec2(170, 260);
			greenCoords[27] = new b2Vec2(196, 198);
			greenCoords[28] = new b2Vec2(205, 137);
			greenCoords[29] = new b2Vec2(210, 84);
			
			redCoords[0] = new b2Vec2(310, 77);
			redCoords[1] = new b2Vec2(343, 68);
			redCoords[2] = new b2Vec2(366, 51);
			redCoords[3] = new b2Vec2(395, 54);
			redCoords[4] = new b2Vec2(415, 92);
			redCoords[5] = new b2Vec2(428, 125);
			redCoords[6] = new b2Vec2(476, 71);
			redCoords[7] = new b2Vec2(473, 97);
			redCoords[8] = new b2Vec2(484, 108);
			redCoords[9] = new b2Vec2(476, 126);
			redCoords[10] = new b2Vec2(464, 146);
			redCoords[11] = new b2Vec2(517, 124);
			redCoords[12] = new b2Vec2(568, 113);
			redCoords[13] = new b2Vec2(606, 121);
			redCoords[14] = new b2Vec2(564, 138);
			redCoords[15] = new b2Vec2(579, 145);
			redCoords[16] = new b2Vec2(535, 157);
			redCoords[17] = new b2Vec2(549, 167);
			redCoords[18] = new b2Vec2(512, 181);
			redCoords[19] = new b2Vec2(522, 195);
			redCoords[20] = new b2Vec2(577, 187);
			redCoords[21] = new b2Vec2(556, 210);
			redCoords[22] = new b2Vec2(581, 227);
			redCoords[23] = new b2Vec2(541, 229);
			redCoords[24] = new b2Vec2(500, 231);
			redCoords[25] = new b2Vec2(442, 241);
			redCoords[26] = new b2Vec2(382, 205);
			redCoords[27] = new b2Vec2(370, 177);
			redCoords[28] = new b2Vec2(357, 145);
			redCoords[29] = new b2Vec2(342, 92);
			
			var i:int = yellowStars.length;
			var ytmp:YellowStarButton;
			for (i = 0; i < 30;i++) {
				ytmp = new YellowStarButton();
				ytmp.x = yellowCoords[i].x;
				ytmp.y = yellowCoords[i].y;
				starsSpr.addChild(ytmp);
				if (i >= maxLevel) ytmp.disable();
				ytmp.planetNum = i;
				ytmp.addEventListener(MouseEvent.CLICK, loadYellowScene);
				yellowStars[i] = ytmp;
			}
			
			i= greenStars.length;
			var gtmp:GreenStarButton;
			for (i = 0; i < 30;i++) {
				gtmp = new GreenStarButton();
				gtmp.x = greenCoords[i].x;
				gtmp.y = greenCoords[i].y;
				starsSpr.addChild(gtmp);
				
				if ((i+30) >= maxLevel) gtmp.disable();
				gtmp.planetNum = i;
				gtmp.addEventListener(MouseEvent.CLICK, loadGreenScene);
				greenStars[i] = gtmp;
			}
			
			
			i= redStars.length;
			var rtmp:RedStarButton;
			for (i = 0; i < 30;i++) {
				rtmp = new RedStarButton();
				rtmp.x = redCoords[i].x;
				rtmp.y = redCoords[i].y;
				starsSpr.addChild(rtmp);
				if ((i+60) >= maxLevel) rtmp.disable();
				rtmp.planetNum = i;
				rtmp.addEventListener(MouseEvent.CLICK, loadRedScene);
				redStars[i] = rtmp;
			}
			
			if (maxLevel < 30) {
				yellowStars[maxLevel-1].animStart();
			}else if (maxLevel < 60) {
				greenStars[maxLevel-31].animStart();
			}else if (maxLevel < 90) {
				redStars[maxLevel-61].animStart();
			}
			
			drawLines();
			
			musicBtn = new MusicButton();
			addChild(musicBtn);
			musicBtn.addEventListener(MouseEvent.CLICK, musicToggle);
			if (!musicAllowed) musicBtn.disable(); 
			musicBtn.y = 20;
			
			fxBtn = new FXButton();
			addChild(fxBtn);
			fxBtn.addEventListener(MouseEvent.CLICK, fxToggle);
			fxBtn.y = 20;
			
			resetBtn = new ResetButton();
			addChild(resetBtn);
			resetBtn.addEventListener(MouseEvent.CLICK, resetBtnHandler);
			
			//resetBitmap = new ResetButton9();
			resetBitmap.addEventListener(ResetButton9.CANCEL, cancelHandler);
			
			if (!soundsAllowed) fxBtn.disable();
			
			if (!soundsAllowed) stopSounds();
			startTime = getTimer();
			
			if (maxLevel == 1) {
				addChild(in5);
				in5OnScene = true;
			}
		}
		
		
		
		private function cancelHandler(e:Event):void 
		{
			removeChild(resetBitmap);
		}
		
		private function resetBtnHandler(e:MouseEvent):void {
			addChild(resetBitmap);
		}
		
		private function loadYellowScene(e:MouseEvent):void {
			if (in5OnScene) {
				removeChild(in5);
				in5OnScene = false;
			}
			var event:SceneEvent = new SceneEvent(SceneEvent.LOAD_SCENE);
			event.scene = YellowStarButton(e.target).planetNum + 6;
			//trace("NewScene=" + event.scene);
			dispatchEvent(event);		
		}
		private function loadGreenScene(e:MouseEvent):void {
			var event:SceneEvent = new SceneEvent(SceneEvent.LOAD_SCENE);
			event.scene = GreenStarButton(e.target).planetNum+36;
			dispatchEvent(event);		
		}
		private function loadRedScene(e:MouseEvent):void {
			var event:SceneEvent = new SceneEvent(SceneEvent.LOAD_SCENE);
			event.scene = RedStarButton(e.target).planetNum+66;
			dispatchEvent(event);		
		}
		
		private function musicToggle(e:MouseEvent):void {
			if (musicBtn.musicOn) {
				dispatchEvent(new Event(MUSIC_ON));
			}else {
				dispatchEvent(new Event(MUSIC_OFF));
			}
		}


		private function fxToggle(e:MouseEvent):void {
			if (fxBtn.FXOn) {
				startSounds();
				dispatchEvent(new Event(FX_ON));
				
			}else {
				trace("Stopsounds scene2");
				stopSounds();
				dispatchEvent(new Event(FX_OFF));
				
			}
		}
		
		private function destroy(e:Event=null):void {
			removeChild(bg);
			//bg.destroy();
			bg = null;
			
			if (contains(in5)) removeChild(in5);
			in5 = null;
			
			removeChild(linesSpr);
			linesSpr = null;
			
			removeChild(starsSpr);
			starsSpr = null;
			
			removeChild(musicBtn);
			musicBtn = null;
			
			removeChild(fxBtn);
			fxBtn = null;
			
			
			
			removeChild(resetBtn);
			resetBtn = null;
			
			if (contains(resetBitmap) )removeChild(resetBitmap);
			resetBitmap.removeEventListener(ResetButton9.CANCEL, cancelHandler);
			//resetBitmap.destroy();
			//resetBitmap = null;
			
		}
		
		public function setVars(max:uint, music:Boolean, fx:Boolean):void {
			if (!music) musicAllowed = false;
				else musicAllowed = true;
			if (!fx) {
				soundsAllowed = false;
			}else soundsAllowed = true;
			
			maxLevel = max;
			
			
		}
		
		public function stopSounds():void {
			
		}
		
		public function startSounds():void {
			
		}
		
		private function drawLines():void {
			linesSpr.graphics.clear();
			var i:int;
			linesSpr.graphics.lineStyle(1, yellowColor, .5);
			linesSpr.graphics.moveTo(yellowCoords[0].x + 8, yellowCoords[0].y + 8);
			var max:int=0;
			for (i = 1; i < (maxLevel<30?maxLevel:30); i++) {
				linesSpr.graphics.lineTo(yellowCoords[i].x + 8, yellowCoords[i].y + 8);
			}
			if (maxLevel > 30) {
				linesSpr.graphics.lineTo(yellowCoords[0].x + 8, yellowCoords[0].y + 8);
				linesSpr.graphics.lineStyle(1, greenColor, .5);
				linesSpr.graphics.moveTo(greenCoords[0].x + 8, greenCoords[0].y + 8);
				
				for (i = 1; i < ((maxLevel)>60?30:(maxLevel-30)); i++) {
					linesSpr.graphics.lineTo(greenCoords[i].x + 8, greenCoords[i].y + 8);
				}
			}
			if (maxLevel > 60) {
				linesSpr.graphics.lineTo(greenCoords[0].x + 8, greenCoords[0].y + 8);
				linesSpr.graphics.lineStyle(1, redColor, .5);
				linesSpr.graphics.moveTo(redCoords[0].x + 8, redCoords[0].y + 8);
				if (maxLevel > 90) max = 30
				else max = maxLevel - 60;
				for (i = 1; i < max; i++) {
					linesSpr.graphics.lineTo(redCoords[i].x + 8, redCoords[i].y + 8);
				}
			if (maxLevel==95)linesSpr.graphics.lineTo(redCoords[0].x + 8, redCoords[0].y + 8);
			}
		}
		
	}
	
}