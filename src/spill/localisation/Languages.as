package spill.localisation
{
	import flash.text.Font;
	import flash.xml.XMLNode;
	
	
	/**
	 * @private
	 */
	public class Languages
	{
		
		public static var languages:Object = new Object();
		private static var _init:Boolean = false;
		
		public static function initialize() : void
		{
			if(_init)return;
			_init = true;
			
			
			var lang:Language;
						
			// nl 
			lang = new Language("nl");
			lang.displayName = "Nederlands";
			lang.p_family = "www.spelletjes.nl";
			lang.p_tween = "www.spel.nl";
			lang.p_girl = "www.girlsgogames.nl";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.p_hyves = "www.zapapa.nl";
			lang.bwcId = 3;
			addLanguage(lang);
			
			// es
			lang = new Language("es");
			lang.displayName = "Español";
			lang.p_family = "www.juegos.com";
			lang.p_tween = "www.zapjuegos.com";
			lang.p_girl = "www.girlsgogames.es";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 9;
			addLanguage(lang);
			
			// pl
			lang = new Language("pl");
			lang.displayName = "Polski";
			lang.p_family = "www.gry.pl";
			lang.p_tween = "www.gry.pl";
			lang.p_girl = "www.girlsgogames.pl";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 6;
			addLanguage(lang);
			
			/*
			// ph
			lang = new Language("ph");
			lang.displayName = "Philipines";
			lang.p_family = "www.laro.com.ph";
			lang.p_tween = "www.laro.com.ph";
			lang.p_girl = "www.laro.com.ph";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.textLanguage = "en_uk";
			addLanguage(lang);
			*/
			
			// fr
			lang = new Language("fr");
			lang.displayName = "Français";
			lang.p_family = "www.jeux.fr";
			lang.p_tween = "www.jeu.fr";
			lang.p_girl = "www.girlsgogames.fr";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 4;
			addLanguage(lang);
			
			// en_us
			lang = new Language("en_us", "us");
			lang.displayName = "English";
			lang.p_family = "www.gamesgames.com";
			lang.p_tween = "www.agame.com";
			lang.p_girl = "www.girlsgogames.com";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 1;
			addLanguage(lang);
			addReference(lang, "en");	
			
			// id
			lang = new Language("id");
			lang.displayName = "Bahasa Ind.";
			lang.p_family = "www.games.co.id";
			lang.p_tween = "www.games.co.id";
			lang.p_girl = "www.games.co.id";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 11;
			addLanguage(lang);
			
			// ru
			lang = new Language("ru");
			lang.displayName = "Русский";
			lang.p_family = "www.ourgames.ru";
			lang.p_tween = "www.flashgames.ru";
			lang.p_girl = "www.girlsgogames.ru";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 12;
			addLanguage(lang);
			
			// se
			lang = new Language("se");
			lang.displayName = "Svenska";
			lang.p_family = "www.spela.se";
			lang.p_tween = "www.spel.se";
			lang.p_girl = "www.girlsgogames.se";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 7;
			addLanguage(lang);
			addReference(lang, "sv");
			
			// it
			lang = new Language("it");
			lang.displayName = "Italiano";
			lang.p_family = "www.gioco.it";
			lang.p_tween = "www.gioco.it";
			lang.p_girl = "www.girlsgogames.it";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 8;
			addLanguage(lang);
			
			// en_uk
			lang = new Language("en_uk", "uk");
			lang.displayName = "English";
			lang.p_family = "www.games.co.uk";
			lang.p_tween = "www.agame.com";
			lang.p_girl = "www.girlsgogames.co.uk";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 13;
			addLanguage(lang);
			
			// cn
			lang = new Language("cn");
			lang.displayName = "中文";
			lang.p_family = "www.game.com.cn";
			lang.p_tween = "www.game.com.cn";
			lang.p_girl = "www.game.com.cn";
			lang.p_teen = "www.game.com.cn";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 2;
			//lang.embedFonts = false;
			lang.embedInputFonts = false;
			//lang.forceFont = "_sans";
			addLanguage(lang);
			addReference(lang, "zh-CN");	
			addReference(lang, "zh-TW");
			
			// pt
			lang = new Language("pt");
			lang.displayName = "Português";
			lang.p_family = "www.ojogos.pt";
			lang.p_tween = "www.ojogos.pt";
			lang.p_girl = "www.ojogos.pt";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 17;
			addLanguage(lang);
			
			/*
			// tr
			lang = new Language("tr");
			lang.displayName = "Türkçe";
			lang.p_family = "www.asoyun.com";
			lang.p_tween = "www.asoyun.com";
			lang.p_girl = "www.girlsgogamestr.com";
			lang.p_teen = "www.a10.com";
			lang.bwcId = 15;
			addLanguage(lang);
			*/
			/*
			// my
			lang = new Language("my");
			lang.displayName = "Bahasa melayu";
			lang.p_family = "www.game.com.my";
			lang.p_tween = "www.game.com.my";
			lang.p_girl = "www.game.com.my";
			lang.p_teen = "www.a10.com";
			lang.bwcId = 16;
			addLanguage(lang);
			*/
			// in
			lang = new Language("in");
			lang.displayName = "English";
			lang.p_family = "www.game.co.in";
			lang.p_tween = "www.game.co.in";
			lang.p_girl = "www.game.co.in";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.textLanguage = "en_uk";	// Set alternative/specific language because we do not translate the countries original language
			lang.bwcId = 14;
			addLanguage(lang);
			
			
			// de
			lang = new Language("de");
			lang.displayName = "Deutsch";
			lang.p_family = "www.jetztspielen.de";
			lang.p_tween = "www.spielen.com";
			lang.p_girl = "www.girlsgogames.de";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 5;
			addLanguage(lang);
			
			// br
			lang = new Language("br");
			lang.displayName = "Português (BR)";
			lang.p_family = "www.ojogos.com.br";
			lang.p_tween = "www.clickjogos.com";
			lang.p_girl = "www.girlsgogames.com.br";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 10;
			addLanguage(lang);
			
			///Font().hasGlyphs(
			///Font.enumerateFonts(false
			
			// jp
			lang = new Language("jp");
			lang.displayName = "日本語";
			lang.p_family = "www.egames.jp";
			lang.p_tween = "www.egames.jp";
			lang.p_girl = "www.egames.jp";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			//lang.embedFonts = true;
			lang.embedInputFonts = false;
			//lang.forceFont = "MS UI Gothic";
			lang.bwcId = 19;
			addLanguage(lang);
			addReference(lang, "ja");

			// Arabic - usage english
			lang = new Language("ar");
			lang.displayName = "English";
			lang.p_family = "www.dailygame.com";
			lang.p_tween = "www.dailygame.com";
			lang.p_girl = "www.dailygame.com";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";
			lang.bwcId = 20;
			addLanguage(lang);
			addReference(lang, "ar");
			
			// Mexico - usage spanish
			lang = new Language("es_mx", "mx");
			lang.displayName = "Español (mx)";
			lang.p_family = "www.juegos.mx";
			lang.p_tween = "www.juegos.mx";
			lang.p_girl = "www.juegosdechicas.mx";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";			
			// TODO what is this ID?
//			lang.bwcId = 9;
			addLanguage(lang);
			addReference(lang, "mx");
			
			// Argentina - usage spanish
			lang = new Language("es_ar", "arg");
			lang.displayName = "Español (ar)";
			lang.p_family = "www.juegos.com.ar";
			lang.p_tween = "www.juegos.com.ar";
			lang.p_girl = "www.juegosdechicas.com.ar";
			lang.p_teen = "www.a10.com";
			lang.p_zapapa = "www.zapapa.com";			
			// TODO what is this ID?
//			lang.bwcId = 9;
			addLanguage(lang);
			addReference(lang, "arg");
		}
		
		private static function addReference(lang:Language, name:String) : void
		{
			languages[name] = lang;
			lang.references.push(name);
		}		
		
		private static function addLanguage(lang:Language) : void
		{
			languages[lang.name] = lang;
		}
		
		public static function getLanguage(name:String) : Language
		{
			return languages[name];
		}
		
		public static function getLanguageByOldID(id:int) : Language
		{
			for each(var l:Language in languages){
				if(l.bwcId == id) return l;
			}
			return null;
		}
				
		
		public static function getLanguagesArray() : Array
		{
			var a:Array = new Array();
			var o:Object = new Object();
			for each(var l:Language in languages){
				if(!o[l.name]){
					a.push(l);
					o[l.name] = true;
				}
			}
			return a;
		}
		
		public static function exportXML() : XMLNode
		{
			var langs:Array = getLanguagesArray();
			var xml:XMLNode = new XMLNode(1,"languages");
			for each(var l:Language in langs){
				xml.appendChild(l.exportXML());
			}
			return xml;
		}
		

	}
}