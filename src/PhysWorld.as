package 
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import Scenes.SceneEvent;
	/**
	 * ...
	 * @author Potapenkov
	 */
	public class PhysWorld extends Sprite{
		// Physics world
		public static const CAN_BURN:String = "canBurn";
		public static const FAIL:String = "fail";
		public var world:b2World;
		
		private var gravity:b2Vec2;
		private var iterations:int = 12;
		private var timeStep:Number = 1/30.0; 
		private var physScale:Number = Parameters.physScale;
		private const K_180_PI:Number = 180 / Math.PI;
		private var bodiesList:b2Body;
		private var tVector:b2Vec2;
		private var fixtureDef:b2FixtureDef;
		private var groundDefination :b2BodyDef;
		private var groundShape:b2PolygonShape;
		public var contactListener:ContactListener;
		public var dbg:Sprite;
		private var debugDraw:b2DebugDraw;
		
		public function PhysWorld() {
			createBox2D();
			addEventListener(Event.ENTER_FRAME, updatePhysicsWorld);
		}
		
		public function destroyWorld():void {
			removeEventListener(Event.ENTER_FRAME, updatePhysicsWorld);
			for (bodiesList = world.GetBodyList(); bodiesList; bodiesList = bodiesList.GetNext()) {
				world.DestroyBody(bodiesList);
			}
			world = null;
			
		}
		
		public function dispathFailEvent():void {
			dispatchEvent(new Event(FAIL));
		}
		private function updatePhysicsWorld(event:Event):void 
		{
			world.Step(timeStep, iterations, iterations);
			//world.ClearForces();
			
			var canBurn:Boolean = true;
		//trace("-------New Step---------");
			for (bodiesList = world.GetBodyList(); bodiesList; bodiesList = bodiesList.GetNext()) {
				if (bodiesList.GetType() == b2Body.b2_staticBody) continue;
				//if (bodiesList.GetFixtureList().GetUserData() == "bub") bodiesList.ApplyForce(new b2Vec2(0, -gravity.y*.2), bodiesList.GetPosition());
				if ((bodiesList.GetFixtureList().GetUserData() != "zombie") &&
					(bodiesList.GetFixtureList().GetUserData() != "met") &&
					(bodiesList.GetFixtureList().GetUserData() != "ground") &&
					(bodiesList.GetFixtureList().GetUserData() != "null"))
						canBurn = false;
					//	trace("Bad Body: " + bodiesList.GetFixtureList().GetBody().GetUserData());
				if ( (bodiesList.GetFixtureList().GetUserData() == "tnt") && ((bodiesList.GetPosition().y * physScale > 370))) {
					trace("destroying " + bodiesList.GetFixtureList().GetBody().GetUserData());
					bodiesList.GetFixtureList().GetBody().GetUserData().destroy();
					
				//	bodiesList.SetAngle(0);
				//	bodiesList.SetType(b2Body.b2_staticBody);
				}
				tVector = bodiesList.GetPosition();
				var ud:DisplayObject= bodiesList.GetUserData();
				ud.x = tVector.x * physScale;
				ud.y = tVector.y * physScale;
				ud.rotation = bodiesList.GetAngle() * K_180_PI;
				
				if (world.GetBodyCount() == 4) {
				//	trace(ud);
				}
			}
			var cc:uint = 0;
			var caf:String="";
			var cbf:String = "";
			var bodyToRotate:b2Body;
			for (var contact : b2Contact = world.GetContactList(); contact != null; contact = contact.GetNext()) {
				
				cc++;
				
					var ca:String = contact.GetFixtureA().GetUserData();
					var cb:String = contact.GetFixtureB().GetUserData();
					
						
					
					if ((ca == "zombie")&&(cb == "met")) {
						caf = ca;
						cbf = cb;
						bodyToRotate = contact.GetFixtureA().GetBody();
					}
					if ((ca == "zombie")&&(cb == "ground")) {
						caf = ca;
						cbf = cb;
						contact.GetFixtureA().GetBody().SetAngle(0);
					}
			}
		
			if ((contactListener.metContact)&&(canBurn)) {
						dispatchEvent(new Event(CAN_BURN));
			}
			if (contactListener.metContact) {
				bodyToRotate.SetAngle(0);
				
			}
			
			
					}
		
		
		public function createBox2D():void 
		{
			contactListener = new ContactListener();
			contactListener.setPhysWorld(this);
			gravity = new b2Vec2(0.0,  Parameters.gravity);
			world = new b2World( gravity, false);
			
			world.SetContactListener(contactListener);
			//createGround
			var groundX:uint = 315;
			var groundY:uint = 375;
			var groundW:uint = 650;
			var groundH:uint = 10;
			var groundBody:b2Body;
			var groundDefination:b2BodyDef;
			var groundShape:b2PolygonShape;
			
			var groundGr:Sprite = new Sprite();
			addChild(groundGr);
			
			groundGr.graphics.beginFill(0x009900);
			groundGr.graphics.drawRect(-groundW/2, -groundH/2, groundW, groundH);
			groundGr.graphics.endFill();
			
			groundGr.x = groundX;
			groundGr.y = groundY;

			
			// создаем и определяем параметры платформы (земли)
			groundDefination = new b2BodyDef();
			groundDefination.type = b2Body.b2_staticBody;
			// задаем координаты. Так как Box2D оперирует метрами (а 0.1 метр = 20 пикселям) то мы должны пиксели привести в метры,
			// а это значит задаваемые значения в пикселях делим на 20.
			groundDefination.position.Set(groundX/physScale, groundY/physScale);
			groundShape = new b2PolygonShape();
			groundShape.SetAsBox((groundW-3)/physScale/2, (groundH-3)/physScale/2);
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = groundShape;
			fixtureDef.friction = Parameters.worldFriction;
			fixtureDef.density = 1; // static bodies require zero density
			fixtureDef.userData = "ground";
			groundDefination.userData = groundGr;
			groundBody = world.CreateBody(groundDefination);
			groundBody.CreateFixture(fixtureDef);
			
			addEventListener(Event.ENTER_FRAME, updatePhysicsWorld, false, 0, true);
		}
		
		
		
		
		
		
		
		
	}
	
}