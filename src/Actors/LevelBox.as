package Actors
{
	

	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.utils.getDefinitionByName;
	
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Bitmap;
	import flash.media.*;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kirill Potapenkov
	 */
	public class LevelBox extends Sprite
	{
		
		[Embed (source ="../../lib/images.swf", symbol="lvlbox.png")]
		private var Lvl0:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl1.png")]
		private var Lvl1:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl2.png")]
		private var Lvl2:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl3.png")]
		private var Lvl3:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl4.png")]
		private var Lvl4:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl5.png")]
		private var Lvl5:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl6.png")]
		private var Lvl6:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl7.png")]
		private var Lvl7:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl8.png")]
		private var Lvl8:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl9.png")]
		private var Lvl9:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl10.png")]
		private var Lvl10:Class;
		
		[Embed (source ="../../lib/images.swf", symbol="lvl11.png")]
		private var Lvl11:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl12.png")]
		private var Lvl12:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl13.png")]
		private var Lvl13:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl14.png")]
		private var Lvl14:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl15.png")]
		private var Lvl15:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl16.png")]
		private var Lvl16:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl17.png")]
		private var Lvl17:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl18.png")]
		private var Lvl18:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl19.png")]
		private var Lvl19:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl20.png")]
		private var Lvl20:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl21.png")]
		private var Lvl21:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl22.png")]
		private var Lvl22:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl23.png")]
		private var Lvl23:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl24.png")]
		private var Lvl24:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl25.png")]
		private var Lvl25:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl26.png")]
		private var Lvl26:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl27.png")]
		private var Lvl27:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl28.png")]
		private var Lvl28:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl29.png")]
		private var Lvl29:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl30.png")]
		private var Lvl30:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl31.png")]
		private var Lvl31:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl32.png")]
		private var Lvl32:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl33.png")]
		private var Lvl33:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl34.png")]
		private var Lvl34:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl35.png")]
		private var Lvl35:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl36.png")]
		private var Lvl36:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl37.png")]
		private var Lvl37:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl38.png")]
		private var Lvl38:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl39.png")]
		private var Lvl39:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl40.png")]
		private var Lvl40:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl41.png")]
		private var Lvl41:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl42.png")]
		private var Lvl42:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl43.png")]
		private var Lvl43:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl44.png")]
		private var Lvl44:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl45.png")]
		private var Lvl45:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl46.png")]
		private var Lvl46:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl47.png")]
		private var Lvl47:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl48.png")]
		private var Lvl48:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl49.png")]
		private var Lvl49:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl50.png")]
		private var Lvl50:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl51.png")]
		private var Lvl51:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl52.png")]
		private var Lvl52:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl53.png")]
		private var Lvl53:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl54.png")]
		private var Lvl54:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl55.png")]
		private var Lvl55:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl56.png")]
		private var Lvl56:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl57.png")]
		private var Lvl57:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl58.png")]
		private var Lvl58:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl59.png")]
		private var Lvl59:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl60.png")]
		private var Lvl60:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl61.png")]
		private var Lvl61:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl62.png")]
		private var Lvl62:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl63.png")]
		private var Lvl63:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl64.png")]
		private var Lvl64:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl65.png")]
		private var Lvl65:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl66.png")]
		private var Lvl66:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl67.png")]
		private var Lvl67:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl68.png")]
		private var Lvl68:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl69.png")]
		private var Lvl69:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl70.png")]
		private var Lvl70:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl71.png")]
		private var Lvl71:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl72.png")]
		private var Lvl72:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl73.png")]
		private var Lvl73:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl74.png")]
		private var Lvl74:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl75.png")]
		private var Lvl75:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl76.png")]
		private var Lvl76:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl77.png")]
		private var Lvl77:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl78.png")]
		private var Lvl78:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl79.png")]
		private var Lvl79:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl80.png")]
		private var Lvl80:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl81.png")]
		private var Lvl81:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl82.png")]
		private var Lvl82:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl83.png")]
		private var Lvl83:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl84.png")]
		private var Lvl84:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl85.png")]
		private var Lvl85:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl86.png")]
		private var Lvl86:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl87.png")]
		private var Lvl87:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl88.png")]
		private var Lvl88:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl89.png")]
		private var Lvl89:Class;
		[Embed (source ="../../lib/images.swf", symbol="lvl90.png")]
		private var Lvl90:Class;
		
		private var images:Vector.<Bitmap>;
		
		
		private var W:Number = 74;
		private var H:Number = 74;
		
		private var framesCount:uint = 91;
		
		
		
		private var currentLevel:uint = 0;
		private var prevLevel:uint = 0;
		
		
		private var dynamicBody:b2Body;
		private var dynamicBodyDefination:b2BodyDef;
		private var dynamicShapeDefination:b2PolygonShape;
		private var fixtureDef:b2FixtureDef;
		private var world:b2World;
	
		private var physScale:Number = Parameters.physScale;
		private var friction:Number = Parameters.woodFriction;
		private var density:Number = Parameters.woodDensity;
		private var restitution:Number=Parameters.woodRestitution;
		//private var drag: Number=8;
		
	
		public function set level(n:uint):void {
			if ((n >= 0) && (n < framesCount)) currentLevel = n;
			showLevel(n);
		}
		public function get level():uint {
			return currentLevel;
		}
		
		public function LevelBox(World:b2World,X:Number=0, Y:Number=0, rot:Number=0, n:uint = 0) {
			world = World;
			x = X;
			y = Y;
			rotation = rot;
			if ((n >= 0) && (n < framesCount)) currentLevel = n;
			
			
			images = new Vector.<Bitmap>(91, true);
			
			/*for (var b:uint = 0; b < 91; b++) {
				trace("images["+b+"] = new Lvl"+b+"();");
				trace("images[" + b + "].x-=W/2;");
				trace("images[" + b + "].y-=W/2;");
			}*/
			
			images[0] = new Lvl0();
images[0].x-=W/2;
images[0].y-=W/2;
images[1] = new Lvl1();
images[1].x-=W/2;
images[1].y-=W/2;
images[2] = new Lvl2();
images[2].x-=W/2;
images[2].y-=W/2;
images[3] = new Lvl3();
images[3].x-=W/2;
images[3].y-=W/2;
images[4] = new Lvl4();
images[4].x-=W/2;
images[4].y-=W/2;
images[5] = new Lvl5();
images[5].x-=W/2;
images[5].y-=W/2;
images[6] = new Lvl6();
images[6].x-=W/2;
images[6].y-=W/2;
images[7] = new Lvl7();
images[7].x-=W/2;
images[7].y-=W/2;
images[8] = new Lvl8();
images[8].x-=W/2;
images[8].y-=W/2;
images[9] = new Lvl9();
images[9].x-=W/2;
images[9].y-=W/2;
images[10] = new Lvl10();
images[10].x-=W/2;
images[10].y-=W/2;
images[11] = new Lvl11();
images[11].x-=W/2;
images[11].y-=W/2;
images[12] = new Lvl12();
images[12].x-=W/2;
images[12].y-=W/2;
images[13] = new Lvl13();
images[13].x-=W/2;
images[13].y-=W/2;
images[14] = new Lvl14();
images[14].x-=W/2;
images[14].y-=W/2;
images[15] = new Lvl15();
images[15].x-=W/2;
images[15].y-=W/2;
images[16] = new Lvl16();
images[16].x-=W/2;
images[16].y-=W/2;
images[17] = new Lvl17();
images[17].x-=W/2;
images[17].y-=W/2;
images[18] = new Lvl18();
images[18].x-=W/2;
images[18].y-=W/2;
images[19] = new Lvl19();
images[19].x-=W/2;
images[19].y-=W/2;
images[20] = new Lvl20();
images[20].x-=W/2;
images[20].y-=W/2;
images[21] = new Lvl21();
images[21].x-=W/2;
images[21].y-=W/2;
images[22] = new Lvl22();
images[22].x-=W/2;
images[22].y-=W/2;
images[23] = new Lvl23();
images[23].x-=W/2;
images[23].y-=W/2;
images[24] = new Lvl24();
images[24].x-=W/2;
images[24].y-=W/2;
images[25] = new Lvl25();
images[25].x-=W/2;
images[25].y-=W/2;
images[26] = new Lvl26();
images[26].x-=W/2;
images[26].y-=W/2;
images[27] = new Lvl27();
images[27].x-=W/2;
images[27].y-=W/2;
images[28] = new Lvl28();
images[28].x-=W/2;
images[28].y-=W/2;
images[29] = new Lvl29();
images[29].x-=W/2;
images[29].y-=W/2;
images[30] = new Lvl30();
images[30].x-=W/2;
images[30].y-=W/2;
images[31] = new Lvl31();
images[31].x-=W/2;
images[31].y-=W/2;
images[32] = new Lvl32();
images[32].x-=W/2;
images[32].y-=W/2;
images[33] = new Lvl33();
images[33].x-=W/2;
images[33].y-=W/2;
images[34] = new Lvl34();
images[34].x-=W/2;
images[34].y-=W/2;
images[35] = new Lvl35();
images[35].x-=W/2;
images[35].y-=W/2;
images[36] = new Lvl36();
images[36].x-=W/2;
images[36].y-=W/2;
images[37] = new Lvl37();
images[37].x-=W/2;
images[37].y-=W/2;
images[38] = new Lvl38();
images[38].x-=W/2;
images[38].y-=W/2;
images[39] = new Lvl39();
images[39].x-=W/2;
images[39].y-=W/2;
images[40] = new Lvl40();
images[40].x-=W/2;
images[40].y-=W/2;
images[41] = new Lvl41();
images[41].x-=W/2;
images[41].y-=W/2;
images[42] = new Lvl42();
images[42].x-=W/2;
images[42].y-=W/2;
images[43] = new Lvl43();
images[43].x-=W/2;
images[43].y-=W/2;
images[44] = new Lvl44();
images[44].x-=W/2;
images[44].y-=W/2;
images[45] = new Lvl45();
images[45].x-=W/2;
images[45].y-=W/2;
images[46] = new Lvl46();
images[46].x-=W/2;
images[46].y-=W/2;
images[47] = new Lvl47();
images[47].x-=W/2;
images[47].y-=W/2;
images[48] = new Lvl48();
images[48].x-=W/2;
images[48].y-=W/2;
images[49] = new Lvl49();
images[49].x-=W/2;
images[49].y-=W/2;
images[50] = new Lvl50();
images[50].x-=W/2;
images[50].y-=W/2;
images[51] = new Lvl51();
images[51].x-=W/2;
images[51].y-=W/2;
images[52] = new Lvl52();
images[52].x-=W/2;
images[52].y-=W/2;
images[53] = new Lvl53();
images[53].x-=W/2;
images[53].y-=W/2;
images[54] = new Lvl54();
images[54].x-=W/2;
images[54].y-=W/2;
images[55] = new Lvl55();
images[55].x-=W/2;
images[55].y-=W/2;
images[56] = new Lvl56();
images[56].x-=W/2;
images[56].y-=W/2;
images[57] = new Lvl57();
images[57].x-=W/2;
images[57].y-=W/2;
images[58] = new Lvl58();
images[58].x-=W/2;
images[58].y-=W/2;
images[59] = new Lvl59();
images[59].x-=W/2;
images[59].y-=W/2;
images[60] = new Lvl60();
images[60].x-=W/2;
images[60].y-=W/2;
images[61] = new Lvl61();
images[61].x-=W/2;
images[61].y-=W/2;
images[62] = new Lvl62();
images[62].x-=W/2;
images[62].y-=W/2;
images[63] = new Lvl63();
images[63].x-=W/2;
images[63].y-=W/2;
images[64] = new Lvl64();
images[64].x-=W/2;
images[64].y-=W/2;
images[65] = new Lvl65();
images[65].x-=W/2;
images[65].y-=W/2;
images[66] = new Lvl66();
images[66].x-=W/2;
images[66].y-=W/2;
images[67] = new Lvl67();
images[67].x-=W/2;
images[67].y-=W/2;
images[68] = new Lvl68();
images[68].x-=W/2;
images[68].y-=W/2;
images[69] = new Lvl69();
images[69].x-=W/2;
images[69].y-=W/2;
images[70] = new Lvl70();
images[70].x-=W/2;
images[70].y-=W/2;
images[71] = new Lvl71();
images[71].x-=W/2;
images[71].y-=W/2;
images[72] = new Lvl72();
images[72].x-=W/2;
images[72].y-=W/2;
images[73] = new Lvl73();
images[73].x-=W/2;
images[73].y-=W/2;
images[74] = new Lvl74();
images[74].x-=W/2;
images[74].y-=W/2;
images[75] = new Lvl75();
images[75].x-=W/2;
images[75].y-=W/2;
images[76] = new Lvl76();
images[76].x-=W/2;
images[76].y-=W/2;
images[77] = new Lvl77();
images[77].x-=W/2;
images[77].y-=W/2;
images[78] = new Lvl78();
images[78].x-=W/2;
images[78].y-=W/2;
images[79] = new Lvl79();
images[79].x-=W/2;
images[79].y-=W/2;
images[80] = new Lvl80();
images[80].x-=W/2;
images[80].y-=W/2;
images[81] = new Lvl81();
images[81].x-=W/2;
images[81].y-=W/2;
images[82] = new Lvl82();
images[82].x-=W/2;
images[82].y-=W/2;
images[83] = new Lvl83();
images[83].x-=W/2;
images[83].y-=W/2;
images[84] = new Lvl84();
images[84].x-=W/2;
images[84].y-=W/2;
images[85] = new Lvl85();
images[85].x-=W/2;
images[85].y-=W/2;
images[86] = new Lvl86();
images[86].x-=W/2;
images[86].y-=W/2;
images[87] = new Lvl87();
images[87].x-=W/2;
images[87].y-=W/2;
images[88] = new Lvl88();
images[88].x-=W/2;
images[88].y-=W/2;
images[89] = new Lvl89();
images[89].x-=W/2;
images[89].y-=W/2;
images[90] = new Lvl90();
images[90].x-=W/2;
images[90].y-=W/2;
			
			addChild(images[prevLevel]);
			
		
			showLevel(n);
			
			init();
			
		}
		
		public function showLevel(n:uint=0):void {
			if((n>=0)&&(n<framesCount))currentLevel = n;
			removeChild(images[prevLevel]);
			addChild(images[currentLevel]);
			
		}
		public function destroy():void {
			
			//removeChild(img); img = null;
			if(aniimTimer.running)aniimTimer.stop();
			aniimTimer.removeEventListener(TimerEvent.TIMER, blinking);
			aniimTimer = null;
			world.DestroyBody(dynamicBody);
			dynamicBody = null;
			dynamicBodyDefination = null;
			dynamicShapeDefination = null;
			fixtureDef = null;
			
		}
		
		
		private var aniimTimer:Timer;
		private var direction:Boolean = false;
		
		public function stopBlink():void {
			aniimTimer.stop();
			alpha = 1;
		}
		
		public function startBlink():void {
			alpha = 0.21;
			aniimTimer.start();
		}
		
		private function blinking(e:TimerEvent):void {
			if (direction) {
				alpha += 0.01;
			}else {
				alpha -= 0.01;
			}
			if (alpha >= 0.5) {
				alpha = 0.5;
				direction = false;
			}
			if (alpha <= 0.2) {
				alpha = 0.2;
				direction = true;
			}
		}
		
		
		public function init():void {
			aniimTimer = new Timer(10);
			aniimTimer.addEventListener(TimerEvent.TIMER, blinking);
			dynamicBodyDefination = new b2BodyDef();
			dynamicBodyDefination.position.Set(x / physScale, y / physScale);
			dynamicBodyDefination.userData = this;
			dynamicBodyDefination.type = b2Body.b2_dynamicBody;
			
			dynamicShapeDefination = new b2PolygonShape();
			dynamicShapeDefination.SetAsBox((W-0) / physScale /2, (H-0) / physScale /2);
			fixtureDef = new b2FixtureDef();
			
			fixtureDef.density = density;		// коефициент плотности объекта
			fixtureDef.friction = friction; 		// коефициент трения объекта
			fixtureDef.restitution = restitution; 	// коефициент упругости
			fixtureDef.userData = "wood";
			fixtureDef.shape = dynamicShapeDefination;
			dynamicBody = world.CreateBody(dynamicBodyDefination);
			dynamicBody.CreateFixture(fixtureDef);
		}
		
		
		
		public function setPosition(vec:b2Vec2):void {
			dynamicBody.SetPosition(vec);
			x = vec.x;
			y = vec.y;
		}
		
		
		public function setRotation(rot:Number):void {
			dynamicBody.SetAngle( rot);
			rotation = rot;
		}
		
		
		
		
	}
	
}