package {
	
	
	
	
	import flash.display.MovieClip;
	import flash.net.SharedObject;
	import Scenes.*;
	import Actors.*;
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Playtomic.*;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.media.*;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.StageScaleMode;
	import spill.localisation.*;
	import Scenes.SceneEvent;
	
			import com.spilgames.api.*;
	
	
	//[SWF(width="640", height="480", frameRate="30", backgroundColor="#000000")]
	//[Frame(factoryClass = "Preloader")]
	[SWF(width="640", height="480", frameRate="30", backgroundColor="#000000")]
	public dynamic class  Main  extends MovieClip
	{
		
		//[Embed(source="sounds/music2.mp3")]
		[Embed(source='../lib/images.swf', symbol='BGMusic')]
		[Bindable]
        private var MusicSndCls:Class;
		private var save:SharedObject;
        private var snd:Sound = new MusicSndCls() as Sound; 
        private var sndChannel:SoundChannel;
            
       private function playMusic(e:Event=null):void {
            sndChannel = snd.play();
			sndChannel.addEventListener(Event.SOUND_COMPLETE, playMusic);
        }   
		private function stopMusic():void {
			if (sndChannel) sndChannel.stop();
		}
		
		
		
				
		
		
		private var main_currentScene:uint = 1;
		private var main_scenesCount:uint =95;
		private var main_scenes:Vector.<Sprite>;
		public var maxLevel:uint = 1;
		public var maxWorld:uint = 1;
		
		public var physWorld:PhysWorld;
		
		public var musicOn:Boolean = true;
		public var fxOn:Boolean = true;
		
		private var _spilGamesServices:SpilGamesServices = SpilGamesServices.getInstance();
		/**
		 * Constructor 
		 */
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
		}
		
		private function onServicesReady(e:Event):void
		{
			// The Submitter is ready to be used.
			trace(_spilGamesServices.isDomainAllowed()); // reads true
			// To submit a score
			ScoreService.submitScore(5);
			// To submit an award
			
		}
		
		private function onServicesFailed (e:Event):void
		{
			trace("Submitter failed to load");
			trace(_spilGamesServices.isDomainAllowed()); // reads false
		} 
	
		private function addToStageHandler(event:Event):void {
			//mochi.as3.MochiServices.connect("99f95ff305d8b362", this, onErrorFunction);
			//MochiAd.showPreGameAd({clip:this, id:"99f95ff305d8b362", res:"640x480", background:0x000000, color:0xFFFF00, outline:0xD58B3C, no_bg:false});
			SpilGame.initialize("Alien_Teleportation", spill.localisation.PortalGroup.ZAPAPA, "Alien_Teleportation.html", this, true);
			
		_spilGamesServices.addEventListener("servicesReady", onServicesReady);
		_spilGamesServices.addEventListener("servicesFailed", onServicesFailed);
		_spilGamesServices.connect(this);
	



			
			
			
			stage.scaleMode = StageScaleMode.NO_SCALE ;
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			playMusic();
			physWorld = new PhysWorld();
			Log.View(2036, "25c23a24ee6447da", root.loaderInfo.loaderURL);
			physWorld.addEventListener(PhysWorld.CAN_BURN, canBurn);
			physWorld.addEventListener(PhysWorld.FAIL, fail);
			
			
			save = SharedObject.getLocal("ZombieDrop");
			if(save.data.maxLevel){
				maxLevel = save.data.maxLevel;
				maxWorld = save.data.maxWorld;
			}
			
			///main_scenes Initialization
			main_scenes = new Vector.<Sprite>();
			main_scenes[0] = null;
			main_scenes[1] = new Scene1(physWorld);
			addChild(main_scenes[1]);
			main_scenes[1].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);	
			main_scenes[2] = new Scene2();
			main_scenes[2].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);
			main_scenes[2].addEventListener(Scene2.FX_OFF, toggleFX);
			main_scenes[2].addEventListener(Scene2.FX_ON , toggleFX);
			main_scenes[2].addEventListener(Scene2.MUSIC_OFF, toggleMusic);
			main_scenes[2].addEventListener(Scene2.MUSIC_ON , toggleMusic);
			Scene2(main_scenes[2]).resetBitmap.addEventListener(ResetButton9.RESET, resetHandler);
			main_scenes[3] = null;
			
			main_scenes[4] = null;
			
			main_scenes[5] = null;
			
			main_scenes[6] = new Scene6(physWorld);
			main_scenes[6].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[6].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[7] = new Scene7(physWorld);
			main_scenes[7].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[7].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[8] = new Scene8(physWorld);
			main_scenes[8].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[8].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[9] = new Scene9(physWorld);
			main_scenes[9].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[9].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[10] = new Scene10(physWorld);
			main_scenes[10].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[10].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[11] = new Scene11(physWorld);
			main_scenes[11].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[11].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[12] = new Scene12(physWorld);
			main_scenes[12].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[12].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[13] = new Scene13(physWorld);
			main_scenes[13].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[13].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[14] = new Scene14(physWorld);
			main_scenes[14].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[14].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[15] = new Scene15(physWorld);
			main_scenes[15].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[15].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[16] = new Scene16(physWorld);
			main_scenes[16].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[16].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[17] = new Scene17(physWorld);
			main_scenes[17].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[17].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[18] = new Scene18(physWorld);
			main_scenes[18].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[18].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[19] = new Scene19(physWorld);
			main_scenes[19].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[19].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[20] = new Scene20(physWorld);
			main_scenes[20].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[20].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[21] = new Scene21(physWorld);
			main_scenes[21].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[21].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[22] = new Scene22(physWorld);
			main_scenes[22].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[22].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[23] = new Scene23(physWorld);
			main_scenes[23].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[23].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[24] = new Scene24(physWorld);
			main_scenes[24].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[24].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[25] = new Scene25(physWorld);
			main_scenes[25].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[25].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[26] = new Scene26(physWorld);
			main_scenes[26].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[26].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[27] = new Scene27(physWorld);
			main_scenes[27].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[27].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[28] = new Scene28(physWorld);
			main_scenes[28].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[28].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[29] = new Scene29(physWorld);
			main_scenes[29].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[29].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[30] = new Scene30(physWorld);
			main_scenes[30].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[30].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[31] = new Scene31(physWorld);
			main_scenes[31].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[31].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[32] = new Scene32(physWorld);
			main_scenes[32].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[32].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[33] = new Scene33(physWorld);
			main_scenes[33].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[33].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[34] = new Scene34(physWorld);
			main_scenes[34].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[34].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[35] = new Scene35(physWorld);
			main_scenes[35].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[35].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			
			main_scenes[36] = new Scene36(physWorld);
			main_scenes[36].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[36].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[37] = new Scene37(physWorld);
			main_scenes[37].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[37].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[38] = new Scene38(physWorld);
			main_scenes[38].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[38].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[39] = new Scene39(physWorld);
			main_scenes[39].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[39].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[40] = new Scene40(physWorld);
			main_scenes[40].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[40].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[41] = new Scene41(physWorld);
			main_scenes[41].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[41].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[42] = new Scene42(physWorld);
			main_scenes[42].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[42].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[43] = new Scene43(physWorld);
			main_scenes[43].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[43].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[44] = new Scene44(physWorld);
			main_scenes[44].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[44].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[45] = new Scene45(physWorld);
			main_scenes[45].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[45].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[46] = new Scene46(physWorld);
			main_scenes[46].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[46].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[47] = new Scene47(physWorld);
			main_scenes[47].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[47].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[48] = new Scene48(physWorld);
			main_scenes[48].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[48].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[49] = new Scene49(physWorld);
			main_scenes[49].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[49].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[50] = new Scene50(physWorld);
			main_scenes[50].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[50].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[51] = new Scene51(physWorld);
			main_scenes[51].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[51].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[52] = new Scene52(physWorld);
			main_scenes[52].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[52].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[53] = new Scene53(physWorld);
			main_scenes[53].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[53].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[54] = new Scene54(physWorld);
			main_scenes[54].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[54].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[55] = new Scene55(physWorld);
			main_scenes[55].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[55].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[56] = new Scene56(physWorld);
			main_scenes[56].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[56].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[57] = new Scene57(physWorld);
			main_scenes[57].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[57].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[58] = new Scene58(physWorld);
			main_scenes[58].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[58].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[59] = new Scene59(physWorld);
			main_scenes[59].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[59].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[60] = new Scene60(physWorld);
			main_scenes[60].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[60].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[61] = new Scene61(physWorld);
			main_scenes[61].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[61].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[62] = new Scene62(physWorld);
			main_scenes[62].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[62].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[63] = new Scene63(physWorld);
			main_scenes[63].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[63].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[64] = new Scene64(physWorld);
			main_scenes[64].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[64].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[65] = new Scene65(physWorld);
			main_scenes[65].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[65].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[66] = new Scene66(physWorld);
			main_scenes[66].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[66].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[67] = new Scene67(physWorld);
			main_scenes[67].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[67].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[68] = new Scene68(physWorld);
			main_scenes[68].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[68].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[69] = new Scene69(physWorld);
			main_scenes[69].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[69].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[70] = new Scene70(physWorld);
			main_scenes[70].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[70].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[71] = new Scene71(physWorld);
			main_scenes[71].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[71].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[72] = new Scene72(physWorld);
			main_scenes[72].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[72].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[73] = new Scene73(physWorld);
			main_scenes[73].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[73].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[74] = new Scene74(physWorld);
			main_scenes[74].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[74].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[75] = new Scene75(physWorld);
			main_scenes[75].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[75].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[76] = new Scene76(physWorld);
			main_scenes[76].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[76].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[77] = new Scene77(physWorld);
			main_scenes[77].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[77].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[78] = new Scene78(physWorld);
			main_scenes[78].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[78].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[79] = new Scene79(physWorld);
			main_scenes[79].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[79].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[80] = new Scene80(physWorld);
			main_scenes[80].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[80].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[81] = new Scene81(physWorld);
			main_scenes[81].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[81].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[82] = new Scene82(physWorld);
			main_scenes[82].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[82].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[83] = new Scene83(physWorld);
			main_scenes[83].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[83].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[84] = new Scene84(physWorld);
			main_scenes[84].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[84].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[85] = new Scene85(physWorld);
			main_scenes[85].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[85].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[86] = new Scene86(physWorld);
			main_scenes[86].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[86].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[87] = new Scene87(physWorld);
			main_scenes[87].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[87].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[88] = new Scene88(physWorld);
			main_scenes[88].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[88].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[89] = new Scene89(physWorld);
			main_scenes[89].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[89].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[90] = new Scene90(physWorld);
			main_scenes[90].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[90].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[91] = new Scene91(physWorld);
			main_scenes[91].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[91].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[92] = new Scene92(physWorld);
			main_scenes[92].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[92].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[93] = new Scene93(physWorld);
			main_scenes[93].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[93].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[94] = new Scene94(physWorld);
			main_scenes[94].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[94].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			main_scenes[95] = new Scene95(physWorld);
			main_scenes[95].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			main_scenes[95].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			
			
		}
		private function onErrorFunction():void 
		{
			trace("Mochi Error!");
		}
		
		private function resetHandler(e:Event):void 
		{
			maxLevel = 1;
			maxWorld = 1;
			save.data.maxWorld = maxWorld;
			save.data.maxLevel = maxLevel;
			removeChild(main_scenes[main_currentScene]);
			Scene2(main_scenes[2]).setVars(maxWorld, musicOn, fxOn);
			addChild(main_scenes[2]);
		}
		
		private function toggleMusic(e:Event):void {
			if (e.type == Scene2.MUSIC_ON) {
				playMusic();
				musicOn = true;
			}else {
				stopMusic();
				musicOn = false;
			}
		}
		private function toggleFX(e:Event):void {
			var tmp:*= main_scenes[main_currentScene];
			if (e.type == Scene2.FX_ON) {
				fxOn = true;
				tmp.startSounds();
				physWorld.contactListener.startSounds();
			}
			else {
				fxOn = false;
				tmp.stopSounds();
				physWorld.contactListener.stopSounds();
			}
		}
		
		private function LevelFinished(e:SceneEvent):void {
			if(maxLevel < (e.scene-4))maxLevel = e.scene-4;
			maxWorld = 1;
			if (maxLevel > 30) maxWorld = 2;
			if (maxLevel > 60) maxWorld = 3;
			save.data.maxLevel = maxLevel;
			save.data.maxWorld = maxWorld;
			save.flush();
			trace(save.data.maxLevel, save.data.maxWorld);
		}
		private function canBurn(e:Event):void {
			//trace("Burning?");
			var tmp:*= main_scenes[main_currentScene]
			tmp.readyToBurn();
		}
		
		
		private function fail(e:Event):void {
			var tmp:*= main_scenes[main_currentScene];
			if(main_currentScene>5)
				tmp.fail();
		}
		
		private function sceneLoader(e:SceneEvent):void {
			
			removeChild(main_scenes[main_currentScene]);
			var newScene:uint = e.scene;
			
			var tmp:*= main_scenes[newScene];
			
			if(newScene>2){
				
				tmp.setVars(maxLevel,  fxOn);
			//	if(newScene==6)addChild(physWorld);
			}else {
				
				tmp.setVars(maxLevel, musicOn, fxOn);
			}
			addChild(main_scenes[newScene]);
			main_currentScene = newScene;
		
		}
		
		
	}
}