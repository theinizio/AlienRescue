package com.spilgames.api
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.Security;
	import flash.utils.getTimer;
	
	/**
	 * Dispatched when the services provided by Spil Games are ready to be receive
	 * requests.
	 * @eventType servicesReady
	 */
	[Event(type="servicesReady", name="flash.events.Event")]
	/**
	 * Dispatched when the intialisation of the services connection fails. The given
	 * ErrorEvent its text property signals what type of error occurred.
	 * 
	 * @eventType servicesFailed
	 * @see com.spilgames.api.SpilGamesServices#INVALID_DOMAIN
	 * @see com.spilgames.api.SpilGamesServices#CONFIGURATION_FAILED
	 */
	[Event(type="servicesFailed", name="flash.events.ErrorEvent")]
	
	/**
	 * SpilGamesServices class is the main class to be used to communicate with services
	 * provided by Spil Games. SpilGamesServices provides the means to setup a connection
	 * and send requests to the services provided.
	 * 
	 * TODO what to do regarding requirements out of our hands.
	 * 
	 * <p>SpilGamesServices is a singleton class. This means only a single instance of
	 * the class can exists. This ensures your game communicates with the Spil Games
	 * services over a single connection. To obtain the single instance you call
	 * <code>SpilGamesService.getInstance()</code>.</p>
	 * 
	 * @example The following code shows how to setup an connection with the Spil Games
	 * services:
	 * 
	 * <listing version="3.0">
	 * import com.spilgames.api.SpilGamesServices;
	 * 
	 * var spilGamesServices:SpilGamesServices = SpilGamesServices.getInstance();
	 * spilGamesServices.addEventListener("servicesReady", onServicesReady);
	 * spilGamesServices.addEventListener("servicesFailed", onServicesFailed);
	 * // <code>this</code> is DisplayObjectContainer which must be attached to
	 * // the display list (its <code>stage</code> property cannot be <code>null</code>
	 * spilGamesServices.connect(this);
	 * 
	 * function onServicesReady(e:Event):void
	 * {
	 *     trace("SpilGamesServices connection ready");
	 * }
	 * 
	 * function onServicesFailed(e:ErrorEvent):void
	 * {
	 *     trace("SpilGamesServices connection failed due to", e.text);
	 * }
	 * </listing>
	 */
	public class SpilGamesServices extends MovieClip
	{
		/**
		 * Signals an invalid id is returned. In most cases the connection is not
		 * ready yet.
		 */
		public static const INVALID_ID:int = -1;
		
		/**
		 * Defines the error message when the game is running at an invalid domain regarding
		 * usage of the Spil Games services.
		 */
		public static const INVALID_DOMAIN:String = "invalidDomain";
		/**
		 * Defines the error message when the connection fails to configure itself. This can
		 * be due to failure to load the configuration settings, which happen when
		 * the configuration fails to load.
		 */
		public static const CONFIGURATION_FAILED:String = "configurationFailure";
		
		private static var _instance:SpilGamesServices = null;
		private const DEFAULT_CONNECTION_LOCATION:String =
			"http://www8.agame.com/games/flash/services/ServicesConnection.swf";
		private static const MAX_CONNECTION_LOAD_RETRIES:uint = 99;
		
		private var _servicesConnection:* = null;
		private var _loader:Loader;
		private var _connecting:Boolean = false;
		private var _connected:Boolean = false;
		private var _request:URLRequest;
		private var _numConnectionLoadTries:uint = 0;
		
		/**
		 * Returns the version of the SpilGamesServices class.
		 */
		public function get version():String
		{
			return "1.1";
		}
		
		/**
		 * Returns whether or not the Spil Games services connection is being setup.
		 * @return <code>true</code> when the connection is being established.
		 */
		public function get connecting():Boolean
		{
			return _connecting;
		}
		
		/**
		 * Returns the instance of the services connection.
		 * @return The instance of the services connection, or <code>null</code> if
		 * one doesn't exist.
		 */
		public function get connection():*
		{
			return _servicesConnection;
		}
		
		private var _alwaysInFront:Boolean = false;
		/**
	     * When set to <code>true</code>, dynamic graphics making part of the SpilGamesServices
		 * will always be in front of the other visuals of your game. This allows dynamic generated
		 * UI's to be displayed upon request, without the need to call <code>bringToFront<code>.
		 *
		 * @see bringToFront
		 */
		public function set alwaysInFront(value:Boolean):void
		{
			if (_alwaysInFront != value)
			{
				_alwaysInFront = value;
				if (_alwaysInFront)
				{
					addEventListener(Event.ENTER_FRAME, bringToFront);
				}
				else
				{
					removeEventListener(Event.ENTER_FRAME, bringToFront);
				}
			}
		}
		/**
		 * @private
		 */
		public function get alwaysInFront():Boolean
		{
			return _alwaysInFront;
		}
		
		/**
		 * @private
		 */
		public function SpilGamesServices(access:Private = null)
		{
			super();
			
			if (!access)
			{
				throw new Error("Cannot instantiate this class, use SpilGamesServices.getInstance");
			}
		}
		
		/**
		 * Returns the sole instance of the SpilGamesServices class.
		 */
		public static function getInstance():SpilGamesServices
		{
			if (!_instance)
			{
				_instance = new SpilGamesServices(new Private());
			}
			return _instance;
		}
		
		/**
		 * Obtains and initialises the Spil Games services connection. This method is
		 * the first method you call.
		 * 
		 * <p>To receive notifications regarding status changes to can add event listeners
		 * before connecting to the Spil Games services. When the connection is established
		 * successfully a <em>servicesReady</em> Event is dispatched. When the connection
		 * cannot be established a <em>servicesFailed</em> ErrorEvent is dispatched.</p>
		 * 
		 * @param clip A DisplayObjectContainer which must be attached to the display
		 * list and stage.
		 * 
		 * @throws An Error when the given <code>clip</code> its <code>stage</code>
		 *   property is <code>null</code>, eg. when the given clip is not part of the
		 *   display list and not added to the stage.
		 */
		public function connect(clip:DisplayObjectContainer, ... rest):void
		{
			if (!_connecting && !_connected)
			{
				if (!clip.stage)
				{
					throw new Error("The given clip must be present in the display list (added to stage)");
				}
				
				_connecting = true;
				
				// Add ourselves directly to the stage object
				clip.stage.addChild(this);
				// We want to get notified when we are removed from stage
				addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
				
				var connectionLocation:String;
				if (root.loaderInfo.parameters["servicesLoc"] && root.loaderInfo.parameters["servicesLoc"].length > 0)
				{
					connectionLocation = root.loaderInfo.parameters["servicesLoc"];
					_request = new URLRequest(connectionLocation);
				}
				else
				{
					connectionLocation = DEFAULT_CONNECTION_LOCATION;
										
					var urlVariables:URLVariables = new URLVariables();
					var date:Date = new Date();
					urlVariables.nocache = ((date.fullYear * 12) + (date.month + 1)) * 31 + date.day;
					
					_request = new URLRequest(connectionLocation);
					_request.data = urlVariables;
				}
				allowDomain(connectionLocation);
				
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoadComplete);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
				
				_loader.load(_request);
			}
		}
		
		/**
		 * Disconnects the SpilGamesServices. Removes all references to the services
		 * connection object. To make use of the services you need to call
		 * <code>connect</code> again.
		 * 
		 * @see connect
		 */
		public function disconnect():void
		{
			if (_servicesConnection)
			{
				_servicesConnection.removeEventListener(Event.COMPLETE, handleServicesReady);
				_servicesConnection.removeEventListener(ErrorEvent.ERROR, handleServicesFailed);
				_servicesConnection.removeEventListener("serviceError", handleServiceError);
					
				if (_connected)
				{
					_servicesConnection.disconnect();
				}
				removeChild(_servicesConnection);
			}
			
			_servicesConnection = null;
			
			if (_loader)
			{
				try
				{
					_loader.close();
				}
				catch (e:Error)
				{
					
				}
				finally
				{
					_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handleLoadComplete);
					_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, handleIOError);
				}
				
				_loader = null;
			}
			
			removeEventListener(Event.ENTER_FRAME, bringToFront);
			removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			if (parent)
			{
				parent.removeChild(this);
			}
			
			_connected = _connecting = false;
		}
		
		/**
		 * Retrieves the id of the Spil Games channel on which the game is running.
		 * 
		 * @return The id of the Spil Games channel on which the game is running,
		 * or an INVALID_ID when the game is not running on a Spil Games channel.
		 */
		public function getChannelID():int
		{
			if (_servicesConnection != null)
			{
				return _servicesConnection.getChannelID();
			}
			else
			{
				//trace("WARNING: SpilGamesServices connection not ready yet");
				return INVALID_ID;
			}
		}
		
		/**
		 * Retrieves the id of the Spil Games site or portal on which the game is running.
		 * 
		 * @return The id of the Spil Games site on which the game is running,
		 * or an INVALID_ID when the game is not running on a Spil Games site.
		 */
		public function getSiteID():int
		{
			if (_servicesConnection != null)
			{
				return _servicesConnection.getSiteID();
			}
			else
			{
				//trace("WARNING: SpilGamesServices connection not ready yet");
				return INVALID_ID;
			}
		}
		
		/**
		 * Returns the numerical id of the game when the game is played on a
		 * Spil Games website.
		 * @return The id of the game or INVALID_ID when the game is not 
		 */
		public function getItemID():int
		{
			if (_servicesConnection != null)
			{
				return _servicesConnection.getItemID();
			}
			else
			{
				return INVALID_ID;
			}
		}
		
		/**
		 * Returns whether or not the SpilGamesServices connection has been
		 * established successfully and the services are ready to be used.
		 */
		public function isReady():Boolean
		{
			return (_servicesConnection != null && _servicesConnection.isReady());
		}
		
		/**
		 * Returns whether or not the domain on which the game is running is allowed to
		 * make use of the Spil Games services.
		 */
		public function isDomainAllowed():Boolean
		{
			return (_servicesConnection != null && _servicesConnection.isDomainValid());
		}
		
		/**
		 * 
		 */
		public function isServiceAvailable(serviceID:String):Boolean
		{
			return (isReady() && _servicesConnection.isServiceAvailable(serviceID));
		}
		
		/**
		 * Sends a request to the Spil Games services. See detailed documentation at each service
		 * class regarding their specific usage, which wrap this function
		 
		 * @param serviceID A String identifier for the specific service to use.
		 * @param functionName A String specifying the function to call.
		 * @param callback A Function with the signature (int, Object):void which handles the returned data.
		 * @param args An Object holding optional arguments to submit to the service function.
		 * @return An identifier of the request, or an INVALID_ID if the connection is not ready yet. This
		 * identifier can be used to keep track of which request calls the given callback.
		 *
		 * @see AwardsService
		 * @see ScoreService
		 */
		public function send(serviceID:String, functionName:String, callback:Function, args:Object = null):int
		{
			if (isReady())
			{
				return _servicesConnection.send(serviceID, functionName, callback, args);
			}
			else
			{
				// -1 signals invalid callback
				return INVALID_ID;
			}
		}
		
		/**
		 * Sets the graphical representations used by SpilGamesServices at the front of the display list.
		 */
		public function bringToFront(e:Event = null):void
		{
			if (parent)
			{
				try
				{
					parent.setChildIndex(this, parent.numChildren - 1);
				}
				catch (e:Error)
				{
					removeEventListener(Event.ENTER_FRAME, bringToFront);
				}
			}
		}
		
		/**
		 * Sets the given domain as allowed in the security sandbox of the current game.
		 */
		public function allowDomain(domain:String):void
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
		}
		
		private function handleRemovedFromStage(e:Event):void
		{
			trace("WARNING: please do not remove SpilGamesServices from the stage");
		}
		
		private function handleLoadComplete(e:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handleLoadComplete);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			
			_servicesConnection = LoaderInfo(e.target).content;
			_servicesConnection.addEventListener(Event.COMPLETE, handleServicesReady);
			_servicesConnection.addEventListener(ErrorEvent.ERROR, handleServicesFailed);
			_servicesConnection.addEventListener("serviceError", handleServiceError);
			
			// Start connection by adding the connection object to the stage
			addChild(_servicesConnection);
		}
		
		private function handleIOError(e:IOErrorEvent):void
		{
			++_numConnectionLoadTries;
			if (_numConnectionLoadTries > MAX_CONNECTION_LOAD_RETRIES)
			{
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handleLoadComplete);
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, handleIOError);
				_connecting = false;
				
				trace("ERROR: SpilGamesServices failed to load the connection object");
				
				if (hasEventListener(e.type))
				{
					dispatchEvent(e);
				}
			}
			else
			{
				trace("WARN: SpilGamesServices failed to load the connection object, retry #" + _numConnectionLoadTries);
				// Wait a few seconds and try again, start by setting the current time on previeousframe time else the difference is huge.
				previousFrameTime = getTimer();
				addEventListener(Event.ENTER_FRAME, updateConnectionRetry);
			}
		}
		
		private var currentDelay:Number = 0;			// Tracks the delay before trying
		private var previousFrameTime:Number;			// Time of the previous frame. used to calculate deltaTime
		private function updateConnectionRetry(e:Event) : void
		{
			// calculate the time between frames.	
			var currentFrameTime:Number = getTimer();
			var deltaTime:Number = (currentFrameTime - previousFrameTime) / 1000; // from milli seconds to seconds
		
			currentDelay += deltaTime;
			if (currentDelay >= 2)	
			{
				trace("WARN: SpilGamesServices trying to reconnect after: " +currentDelay );
				_loader.load(_request);
				removeEventListener(Event.ENTER_FRAME, updateConnectionRetry);
				currentDelay = 0;
			}			
		
			previousFrameTime = currentFrameTime;
		}
		
		private function handleServicesReady(e:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handleLoadComplete);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			
			_connected = true;
			_connecting = false;
			
			//trace("INFO: SpilGamesServices are connected and ready");
			
			dispatchEvent(new Event("servicesReady"));
		}
		
		private function handleServicesFailed(e:ErrorEvent):void
		{
			_servicesConnection.addEventListener(Event.COMPLETE, handleServicesReady);
			_servicesConnection.addEventListener(ErrorEvent.ERROR, handleServicesFailed);
			_servicesConnection.addEventListener("serviceError", handleServiceError);
			
			_connecting = false;
			
			//trace("ERROR: SpilGamesServices failed to initialise due to '" + e.text + "'");
			
			// Check, since we dispatch an error event (which must be handled for correct user experience)
			if (hasEventListener("servicesFailed"))
			{
				dispatchEvent(new ErrorEvent("servicesFailed", false, false, e.text));
			}
		}
		
		private function handleServiceError(e:Event):void
		{	
			if (hasEventListener("serviceError"))
			{
				var message:String = "";
				if (e is ErrorEvent)
				{
					message = ErrorEvent(e).text;
				}
				else
				{
					message = e.toString();
				}
				
				dispatchEvent(new ErrorEvent("serviceError", false, false, message));
			}
		}
	}
}

/**
 * @private
 */
internal class Private {}