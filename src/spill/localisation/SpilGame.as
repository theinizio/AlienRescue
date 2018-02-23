/*
 Legal
*/
package spill.localisation
{
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.LocalConnection;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	/**
	* Dispatched when the current language has been changed
	*
	* @eventType spill.localisation.SpilGame.LANGUAGE_CHANGED
	*/
	[Event(name="languageChanged", type="spill.localisation.SpilGame.LANGUAGE_CHANGED")]
	
	
	/**
	* Dispatched when the current branding has been changed
	*
	* @eventType spill.localisation.SpilGame.BRANDING_CHANGED
	*/
	[Event(name="brandingChanged", type="spill.localisation.SpilGame.BRANDING_CHANGED")]

			
	/**
	 * Main Static class that manages branding and localisation. This should be
	 * initialised at the begining of the game, before any localisation or branding 
	 * is present
	 * 
	 * @author Sjoerd Schoneveld
	 */	
	 
	public class SpilGame
	{
		
		
		
		//=============================================================================
		//
		// Public Methods
		//
		//=============================================================================	
			

		//-----------------------------------------------------------------------------
		// Initialisation
		//-----------------------------------------------------------------------------
		
		/**
		 * Initialises the localisation and Branding system
		 * 
		 * @param gameName Name of the game, must not contain spaces or special characters.
		 * @param portalGroup Which portal group the game belongs to. <code>PortalGroup.GIRL</code>, for example
		 * @param emailPage The filename of the send to friend page for this game
		 * @param sprite Supplied display object for context menu instantiation
		 * @param _channelLock 
		 * 
		 * @example The following initializes a girls game called "My Game"
		 *  <listing version="3.0" >SpilGame.initialise("My_Game", PortalGroup.GIRL, "My-Game.html", this);</listing>
		 * 
		 * @see PortalGroup
		 * 
		 */			
		public static function initialize(_gameName:String, _portalGroup:int, _emailPage:String, s:Sprite, _channelLock:Boolean = false) : void
		{
			stage = s;
			/// Make sure we only initialise once
			if(_init){
				trace("ERROR: LocalisationManager already initialised");
				return;
			} else {
				_init = true;
			}
			
			/// Local domains for testing
			localDomains["localhost"] = true;
			localDomains["www8.agame.com"] = true;
			localDomains["gamedev.dev.spilgames.com"] = true;
			// If you are testing from a staging enviroment, please adjust the adres below or add another entry
			localDomains["stg.spel.nl"] = true;
			localDomains["stg.girlsgogames.nl"] = true;
			localDomains["stg.pl.spel.nl"] = true;
			localDomains["stg.pl.girlsgogames.nl"] = true;
			trace(localDomains["stg.girlsgogames.nl"]);
			/// Initialise Languages and Branding
			
			Brandings.initialize();
			Languages.initialize();
			initContexMenu(s);
			
			
			/// Set game properties
			channelLock = _channelLock;
			gameName = _gameName.replace(" ", "_");
			portalGroup = _portalGroup;
			emailPage = _emailPage;
			
			// Choose language
			chooseLanguage();
			
			// Set branding based on language
			chooseBranding();
			
			if (portalGroup == PortalGroup.HYVES)
			{
				changeLanguage("nl");
			}
		}
		
		/** @private */
		public static function initTextField(txt:TextField) : void
		{
			trace(txt.text);
			txt.text = txt.text.replace(/{([^{}]*)}/g, replaceFn);
			trace(txt.text);
			txt.embedFonts = currentLanguage.embedFonts;
			if(currentLanguage.forceFont != ""){
				var tf:TextFormat = new TextFormat();
				tf.font = currentLanguage.forceFont;
				txt.setTextFormat(tf);	
			}
		}
		
		/** @private */
		private static function replaceFn() : String
		{	
			var str:String = SpilGame.getString(arguments[1]);
			if(!str || str == ""){
				return "{" + arguments[1] + "}";
			} else { 
				//str = str.replace(regex, replaceFn);
				return str;
			}
		}
				
		//-----------------------------------------------------------------------------
		// Click Link Functions
		//-----------------------------------------------------------------------------
		
		public static function outputAllBrands() : String
		{
			var a:Array = Brandings.getBrandsArray();
			var str:String = "";
			for each(var b:Brand in a){
				str += b.getSendToFriendLink(gameName, emailPage, isExternal, embedDomain) + "\n";	
			}
			return str;
		}
		
		public static function traceAllBrands() : void
		{
			trace(outputAllBrands());
		}
		
		
		/** 
		 * Returns the 'more games' link.
		 * 
		 * @param term optional term for google analitics, should describe where in the
		 *  game the link is
		 */			
		public static function getMoreGamesLink(term:String = "") : String
		{

		

			var domain:String = embedDomain ? embedDomain : hostingDomain;

			

			//if(isExternal && !embedDomain){
			//	domain = hostingDomain;
			//}
			return currentBranding.getMoreGamesLink(gameName, isExternal, domain, term);
		}
		
		/**
		 * Returns link to use for send to friend functionality
		 */			
		public static function getSendToFriendLink() : String
		{
			return currentBranding.getSendToFriendLink(gameName, emailPage, isExternal, embedDomain);
		}

		/**
		 * Returns link to use for Promotion functionality like "Play with friend for highscores, achievements and more"
		 */			
		public static function getPromotionLink(term:String = "feature_promotion") : String
		{
			var domain:String = embedDomain ? embedDomain : hostingDomain;
			return currentBranding.getPromotionLink(gameName, emailPage, isExternal, domain, term);
		}
				
		/**
		 * Returns the spil company link
		 */			
		public static function getSpilCompanyLink() : String
		{
			var link:String = "http://www.gameportal.net/";
			link += "?utm_medium=brandedgames_" + (isExternal ? "external" : "internal");
            link += "&utm_campaign=" + gameName;
            link += "&utm_source=" + Brand.stripSubDomain(embedDomain ? embedDomain : hostingDomain);
            link += "&utm_content=Branding_Link";
            
            return link;
		}


		//-----------------------------------------------------------------------------
		// Localised Text Data
		//-----------------------------------------------------------------------------
		// To_Do make sure xml is valid
			
		/**
		 * Imports XML Language Data
		 * @private
		 */	
		public static function importXML(data:XML) : void
		{
			for each(var record:XML in data.children()){
				var o:Object = strings[record.identifier] = new Object();
				for each(var item:XML in record.children()){
					o[item.name()] = item.children()[0].toString();
				}
			}
		}
		/**
		 * Imports XML Language Data
		 * @private
		 */	
		public static function importXMLv2(data:XML) : void
		{
			for each(var record:XML in data.children()){
				var o:Object = strings[record.attribute("identifier")] = new Object();
				for each(var item:XML in record.children()){
					if(item.children().length() > 0){
						o[item.name()] = item.children()[0].toString();
					} else {
						o[item.name()] = "";
					}
				}
			}
		}
		
		/**
		 * Returns a localised version of the requested string identifier. Identifier
		 * names for localised strings can be found in the supplied Excel localisation
		 * file
		 */	
		public static function getString(identifier:String) : String
		{
			var item:Object = strings[identifier];
			
			if(item){
				
				if(currentLanguage.textLanguage){
					
					return item[currentLanguage.textLanguage];
				} else {
					if (item[currentLanguage.name])
					{
						return item[currentLanguage.name];
					}
					else
					{
						// en_us fallback
						return item["en_us"];
					}
				}
			} else {
				return "";
			}
		}		
		
		
		
		//=============================================================================
		//
		// Private/internal methods/properties
		//
		//=============================================================================	
		/** @private */	
		spil_internal static var gameName:String;
		/** @private */	
		public static var currentBranding:Brand;
		/** @private */	
		public static var currentLanguage:Language;
		/** @private */	
		spil_internal static var emailPage:String;
		/** @private */	
		spil_internal static var portalGroup:uint;
		private static var channelLock:Boolean = false;
		private static var _init:Boolean = false;
		private static var eventDispatcher:EventDispatcher;
		private static var localDomains:Object = new Object();
		private static var strings:Object = new Object();
		private static var contexMenuItem:ContextMenuItem;
				
		private static var stage:Sprite;
				
		//-----------------------------------------------------------------------------
		// Contex Menu
		//-----------------------------------------------------------------------------
		
		private static function initContexMenu(s:Sprite) : void
		{
			contexMenuItem = new ContextMenuItem("");
			s.contextMenu = new ContextMenu();
			s.contextMenu.customItems.push(contexMenuItem);
			contexMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, contexMenuClicked);
		}
		
		private static function contexMenuClicked(e:ContextMenuEvent) : void
		{
			navigateToURL(new URLRequest(getMoreGamesLink("Contex_Menu")));
		}
				
		//-----------------------------------------------------------------------------
		// Language and Branding Selection
		//-----------------------------------------------------------------------------
		
		/// Chooses what language to use
		/** @private */	
		spil_internal static function chooseLanguage() : void
		{
			
			// 
			if(cookieLanguage != null){
				
				// If cookie is present
				// Use that language
				currentLanguage = cookieLanguage;
								
			} else {
				
				if(isExternal){
					
					// If file is external and no cookie is present
					// Use system language
					currentLanguage = systemLanguage;
					
				} else {
					
					// If file is internal and no cookie present
					// Use language from portal
					currentLanguage = portalLanguage;
					
					// If unable to determine for some reason, use system language
					if(!currentLanguage){
						currentLanguage = systemLanguage;
					}

				}				
				
			}
			
			// Use default language if it fails for some reason
			if(!currentLanguage){
				trace("Unable to determine language, using 'English US'");
				currentLanguage = Languages.getLanguage("en_us");
			}
				
			TextFieldFit.embedFonts = currentLanguage.embedFonts;
			TextFieldFit.forceFont = currentLanguage.forceFont;
			
			dispatchEvent(new Event(LANGUAGE_CHANGED));
		}
		
		/** @private */	
		spil_internal static function chooseBranding() : void
		{
			//Disabled the check to see if the game is hosted on an external portal
			//All games are now treated as being hosted externally
			//so that the portalgroup logo's are always shown rather then the portal
			//that the game is hosted on
			currentBranding = Brandings.getBrandByDomain(currentLanguage.portal_groups[portalGroup]);
			
			if(!(currentBranding is Brand)){
				currentBranding = Brandings.getBrandByDomain("www.agame.com");
			}
			
			contexMenuItem.caption = "More Games: " + currentBranding.domain;
			
			dispatchEvent(new Event(BRANDING_CHANGED));
			
		}
		
		/** @private */	
		spil_internal static function changeLanguage(langid:String) : void
		{
			
			var newLanguage:Language = Languages.getLanguage(langid);
			if(!newLanguage){
				trace("ERROR: Supplied language string does not have a matching language")
			} else {
				cookieLanguage = newLanguage;
				currentLanguage = newLanguage;
			}
			
			TextFieldFit.embedFonts = currentLanguage.embedFonts;
			TextFieldFit.forceFont = currentLanguage.forceFont;
						
			// Set branding based on language
			chooseBranding();
			
			dispatchEvent(new Event(LANGUAGE_CHANGED));
			
		}

		
		
		//-----------------------------------------------------------------------------
		// Language Preferences
		//-----------------------------------------------------------------------------
		
		
		private static function get portalLanguage() : Language
		{
			
			if(isExternal){
				return null;
			} else {
				
				if(!embedDomain) return null;
				
				var brand:Brand = Brandings.getBrandByDomain(embedDomain);
				if(!brand) return null;
						
				var langString:String = brand.preferedLanguage;
				if(!langString) return null;
				
				var lang:Language = Languages.getLanguage(langString);
				if(!lang) return null;

				return lang;
				
			}
			
		}
		
		/// Returns the Systems language
		/** @private */	
		spil_internal static function get systemLanguage() : Language
		{
			return Languages.getLanguage(Capabilities.language);
		}
		
		
		//-----------------------------------------------------------------------------
		// Cookie Management
		//-----------------------------------------------------------------------------
		
		// Path to language preference cookie (always same)
		private static const cookiePath:String = "/";
		
		// Name of language preference cookie (always same)
		private static const cookieName:String = "spilgames_language_v100";
		
		// Name of language variable saved in cookie (always same)
		private static const cookieLanguageVar:String = "savedLang";
			
				
		/// Returns language from cookie if available
		/** @private */	
		spil_internal static function get cookieLanguage() : Language
		{
			var cookie:SharedObject = SharedObject.getLocal(cookieName, cookiePath);
			var lang:String = String(cookie.data[cookieLanguageVar]);
			return Languages.getLanguage(lang);

		}
		
		
		/// Sets the cookie language
		/** @private */	
		spil_internal static function set cookieLanguage(lang:Language) : void
		{
			var cookie:SharedObject = SharedObject.getLocal(cookieName, cookiePath);
			if(lang == null){
				cookie.data[cookieLanguageVar] = null;				
			} else {
				cookie.data[cookieLanguageVar] = lang.name;
			}
			cookie.flush();
		}
		

		
		//-----------------------------------------------------------------------------
		// Domain Information
		//-----------------------------------------------------------------------------


		public static function get isExternal() : Boolean
		{
			return 	!Brandings.hasDomain(embedDomain) && 
					//!localDomains[hostingDomain] &&
					!localDomains[embedDomain] &&
					// Added check for staging domain
					!isStagingDomain;
		}
		
		/**
		 * Returns whether or not the domain in which the game is embedded is a
		 * staging domain. A staging domain starts with stg. (ie. stg.pl).
		 */
		public static function get isStagingDomain():Boolean
		{
			var domain:String = "http://" + embedDomain;
			return domain.indexOf("http://stg.") >= 0;
		}

		
		///----------------------------------------------------------------------------
		// Manage finding and storing the domain the SWF file is hosted on
		
		/** @private */	
		spil_internal static var debugHostDomain:String = "";
		/** @private */	
		spil_internal static function get hostingDomain() : String
		{
			if(debugHostDomain != ""){
				return debugHostDomain;
			} else {
			
				var localConnection:LocalConnection = new LocalConnection();
				return localConnection.domain;
			}
		}
		
		///----------------------------------------------------------------------------
		/// Manage finding and storing the domain the SWF file is embedded in
		
		/** @private */	
		spil_internal static var debugEmbedDomain:String = "";
		/** @private */	
		spil_internal static function get embedDomain() : String
		{
			
			if(debugEmbedDomain != "") return debugEmbedDomain;
			
			if(ExternalInterface.available){
				try {
					var loc:String = ExternalInterface.call("window.location.href.toString");
					if(loc != "" && loc != null){
						trace("embed domain = " + getDomain(loc));
						return getDomain(loc);
					} else {
						//trace("No valid domain retrieved from embed location");
					}
				} catch (e:SecurityError){
					trace("Security Error connecting to external interface, error = " + e);
				} catch (e:Error) {
					trace("Error connecting to external interface, error = " + e);
				}
			} else {
				//trace("External interface not available, unable to determine embed url");
			}
			return null;			
		}


		//-----------------------------------------------------------------------------
		// Event Dispatcher API
		//-----------------------------------------------------------------------------
	
		public static const LANGUAGE_CHANGED:String = "languageChanged";
		public static const BRANDING_CHANGED:String = "brandingChanged";
				
		/** @private */	
  		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void 
  		{
  			if(!eventDispatcher)eventDispatcher = new EventDispatcher();
   			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
   		}
   		
   		/** @private */	
  		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void 
  		{
   			if(!eventDispatcher)eventDispatcher = new EventDispatcher();
   			eventDispatcher.removeEventListener(type, listener, useCapture);
   		}
   		
   		/** @private */	
  		spil_internal static function dispatchEvent(event:Event):void 
  		{
   			if(!eventDispatcher)eventDispatcher = new EventDispatcher();
   			eventDispatcher.dispatchEvent(event);
   		} 


		//-----------------------------------------------------------------------------
		// Utility Functions
		//-----------------------------------------------------------------------------


		public static function exportXML() : XML
		{
			var root:XML = <spil_games />;
			root.appendChild(Brandings.exportXML());
			root.appendChild(Languages.exportXML());
			root.appendChild(PortalGroup.exportXML());
			return root;
		}

		private static function getDomain(url:String) : String
		{
			if(url.indexOf("file") == 0){
				return "offline_play";
			} else {
				var domain:String = new String();
				for (var j:uint=7; j<url.length; j++){				  
					if(url.charAt(j) == "/"){
						break;
					}
					domain += url.charAt(j);
				}
				if(domain == "localhost") domain = "offline_play";
				return domain;
			}

		}

	}
	
}