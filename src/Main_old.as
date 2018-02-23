package {
	
	
	
	import Actors.Bub3;
	import Actors.Numbers;
	import Actors.ResetButton;
	import Actors.Tire2;
	import Actors.World3bg;
	import Scenes.Scene1;
	import Scenes.Scene2;
	import Scenes.Scene3;
	import Scenes.Scene6;
	import Scenes.Scene7;
	import Scenes.SceneEvent;
	
	import Actors.CompleteButton;
	import Actors.Explosion;
	import Actors.FailButton;
	import Actors.FXButton;
	import Actors.HomeButton;
	import Actors.LeftArrowButton;
	import Actors.Level;
	import Actors.Lights;
	import Actors.Logo;
	import Actors.Met1;
	import Actors.Met2;
	import Actors.Met3;
	import Actors.Met4;
	import Actors.Met5;
	import Actors.Met8;
	import Actors.MusicButton;
	import Actors.PauseButton;
	import Actors.RefreshButton;
	import Actors.RightArrowButton;
	import Actors.ShocksButton;
	import Actors.Tire1;
	import Actors.Tnt4;
	import Actors.Tur;
	import Actors.Wood6;
	import Actors.World2bg;
	
	import Actors.World1bg;
	import Actors.World1city1;
	
	import Actors.Zombie1;
	import Actors.Zombie1Explosion;
	import Actors.Zombie2;
	import Actors.Zombie3;
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
	import Box2D.FpsCounter;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.media.*;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	
	[SWF(width="630", height="420", frameRate="50", backgroundColor="#000000")]
	public class Main extends Sprite
	{
		
		[Embed(source="sounds/music2.mp3")]
        [Bindable]
        public var MusicSndCls:Class;
            
        public var snd:Sound = new MusicSndCls() as Sound; 
        public var sndChannel:SoundChannel;
            
       private function playMusic(e:Event=null):void {
            sndChannel = snd.play();
			sndChannel.addEventListener(Event.SOUND_COMPLETE, playMusic);
        }   
		private function stopMusic():void {
			if (sndChannel) sndChannel.stop();
		}
		
		private var fps:FpsCounter;
		// Временные переменные которые созданы с целю оптимизации процесса, чтобы каждый раз не создавать их в коде.
				
		
		
		private var currentScene:uint = 1;
		private var scenesCount:uint =8;
		private var scenes:Vector.<Sprite>;
		public var maxLevel:uint = 1;
		public var maxWorld:uint = 1;
		
		public var physWorld:PhysWorld;
		
		
		
		
		/**
		 * Constructor 
		 */
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		/**
		 * Event handler of 
		 *
		 * @param event
		 */
		private function addToStageHandler(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			fps = new FpsCounter();
			addChild(fps);
			physWorld = new PhysWorld();
			physWorld.addEventListener(PhysWorld.CAN_BURN, canBurn);
			physWorld.addEventListener(PhysWorld.FAIL, fail);
			
			
			addEventListener(Event.ENTER_FRAME, updateMain);	
			///Scenes Initialization
			scenes = new Vector.<Sprite>(scenesCount, true);
			scenes[0] = null;
			scenes[1] = new Scene1();
			addChild(scenes[1]);
			scenes[1].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);	
			scenes[2] = new Scene2();
			scenes[2].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);
			scenes[3] = new Scene3(physWorld.world, maxLevel);
			scenes[3].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);
			scenes[4] = new Scene3(physWorld.world, maxLevel);
			scenes[4].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);
			scenes[5] = new Sprite();
			scenes[6] = new Scene6(physWorld.world);
			scenes[6].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			scenes[6].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
			scenes[7] = new Scene7(physWorld.world);
			scenes[7].addEventListener(SceneEvent.LOAD_SCENE, sceneLoader);		
			scenes[7].addEventListener(SceneEvent.LEVEL_FINISHED, LevelFinished);
		}
		
		private function LevelFinished(e:SceneEvent):void {
			maxLevel = e.scene-4;
			if (maxLevel > 30) maxWorld = 2;
			if (maxLevel > 60) maxWorld = 3;
			trace(maxLevel, maxWorld);
		}
		private function canBurn(e:Event):void {
			//trace("Burning?");
			var tmp:*= scenes[currentScene]
			tmp.readyToBurn();
		}
		
		
		private function fail(e:Event):void {
			var tmp:*= scenes[currentScene]
			if(currentScene>5)
				tmp.fail();
		}
		
		private function sceneLoader(e:SceneEvent):void {
			removeChild(scenes[currentScene]);
			var newScene:uint = e.scene;
			var tmp:*= scenes[newScene];
			if (newScene > 2) tmp.setMaxLevel(maxLevel) else tmp.setMaxWorld(maxWorld);
			currentScene = newScene;
			addChild(scenes[newScene]);
		}
		
		private function updateMain(e:Event):void {
			fps.update();
		}
	}
}