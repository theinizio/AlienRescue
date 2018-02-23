package spill.localisation
{
	import flash.xml.XMLNode;
	
	
	/**
	 * @private
	 */
	public class Brandings
	{
		
		
		private static var brands_by_id:Object = new Object();
		private static var brands_by_domain:Object = new Object();
		
		public static function initialize () : void
		{
			
			var brand:Brand;
			
			// Agame.com - English - US
			brand = new Brand();
			brand.site_id = 79;
			brand.domain = "www.agame.com";
			brand.preferedLanguage = "en_us";
			brand.portalGroup = PortalGroup.TEENS;
			//brand.backgroundColor = 0xFFFFFF;
			addBrand(brand);
			
			// Gamesgames.com - English - US
			brand = new Brand();
			brand.site_id = 88;
			brand.domain = "www.gamesgames.com";
			brand.preferedLanguage = "en_us";
			brand.portalGroup = PortalGroup.FAMILY;
			addBrand(brand);
			
			// girlsgogames.com - English - US
			brand = new Brand();
			brand.site_id = 90;
			brand.domain = "www.girlsgogames.com";
			brand.preferedLanguage = "en_us";
			brand.portalGroup = PortalGroup.GIRL;
			addBrand(brand);
			
			// A10 - All Languages
			brand = new Brand();
			brand.site_id = 45;
			brand.domain = "www.a10.com";
			brand.preferedLanguage = "en_us";
			brand.portalGroup = PortalGroup.YOUNG_ADULTS;
			addBrand(brand);	
			
			
			// Games.co.uk - English - UK
			brand = new Brand();
			brand.site_id = 92;
			brand.domain = "www.games.co.uk";
			brand.preferedLanguage = "en_uk";
			brand.portalGroup = PortalGroup.FAMILY;
			addBrand(brand);
			
			/*
			// Mygames.co.uk - English - UK
			brand = new Brand();
			brand.site_id = 107;
			brand.domain = "www.mygames.co.uk";
			brand.preferedLanguage = "en_uk";
			brand.portalGroup = PortalGroup.TEENS;
			addBrand(brand);
			*/

			// Agame.co.uk - English - UK
			brand = new Brand();
			brand.site_id = 107;
			brand.domain = "www.agame.co.uk";
			brand.preferedLanguage = "en_uk";
			brand.portalGroup = PortalGroup.TEENS;
			addBrand(brand);
		
			
			/*
			// agames.co.uk - English - UK
			brand = new Brand();
			brand.site_id = 107;
			brand.domain = "www.agame.co.uk";
			brand.preferedLanguage = "en_uk";
			brand.portalGroup = PortalGroup.TEENS;
			addBrand(brand);
			*/
			
			// girlsgogames.co.uk - English - UK
			brand = new Brand();
			brand.site_id = 102;
			brand.domain = "www.girlsgogames.co.uk";
			brand.preferedLanguage = "en_uk";
			brand.portalGroup = PortalGroup.GIRL;
			addBrand(brand);
									
			
			// Game.com.cn - Chinese
			brand = new Brand();
			brand.site_id = 2;
			brand.domain = "www.game.com.cn";
			brand.moreLink = "moregames/";
			brand.preferedLanguage = "cn";
			brand.portalGroup = PortalGroup.NONE;
			brand.useGoogleAnalitics = false;
			brand.hasSendToFriendLink = false;
			addBrand(brand);
			
			// Spel.nl - Dutch
			brand = new Brand();
			brand.site_id = 25;
			brand.domain = "www.spel.nl";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "nl";
			
			addBrand(brand);
			
			// Spelletjes.nl - Dutch			
			brand = new Brand();
			brand.site_id = 1;
			brand.domain = "www.spelletjes.nl";
			brand.emailLink = "spel";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "nl";
			addBrand(brand);
			
			// girlsgogames.nl - Dutch
			brand = new Brand();
			brand.site_id = 93;
			brand.domain = "www.girlsgogames.nl";
			brand.emailLink = "spel";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "nl";
			addBrand(brand);
			
			// Jeu.fr - French
			brand = new Brand();
			brand.site_id = 12;
			brand.domain = "www.jeu.fr";
			brand.emailLink = "jeu";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "fr";
			addBrand(brand);
			
			// girlsgogames.fr - French
			brand = new Brand();
			brand.site_id = 95;
			brand.domain = "www.girlsgogames.fr";
			brand.emailLink = "jeu";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "fr";
			addBrand(brand);			
				
			//Jeux.fr - French
			brand = new Brand();
			brand.site_id = 11;
			brand.domain = "www.jeux.fr";
			brand.emailLink = "jeu";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "fr";
			addBrand(brand);
			
			// Spielen.com - German
			brand = new Brand();
			brand.site_id = 26;
			brand.domain = "www.spielen.com";
			brand.emailLink = "spiel";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "de";
			addBrand(brand);
			
			// girlsgogames.de - German
			brand = new Brand();
			brand.site_id = 94;
			brand.domain = "www.girlsgogames.de";
			brand.emailLink = "spiel";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "de";
			addBrand(brand);	
			
			// Jetztspielen.de - German
			brand = new Brand();
			brand.site_id = 5;
			brand.domain = "www.jetztspielen.de";
			brand.emailLink = "spiel";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "de";
			addBrand(brand);
			
			// Minigry.pl - Polish
			brand = new Brand();
			brand.site_id = 109;
			brand.domain = "www.minigry.pl";
			brand.emailLink = "gra";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "pl";
			addBrand(brand);
						
			// Gry.pl - Polish
			brand = new Brand();
			brand.site_id = 16;
			brand.domain = "www.gry.pl";
			brand.emailLink = "gra";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "pl";
			addBrand(brand);
			
			// girlsgogames.pl - Polish
			brand = new Brand();
			brand.site_id = 98;
			brand.domain = "www.girlsgogames.pl";
			brand.emailLink = "gra";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "pl";
			addBrand(brand);
						
			// Spel.se - Swedish	
			brand = new Brand();
			brand.site_id = 108;
			brand.domain = "www.spel.se";
			brand.emailLink = "spel_";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "se";
			addBrand(brand);
			
			// girlsgogames.se - Swedish
			brand = new Brand();
			brand.site_id = 100;
			brand.domain = "www.girlsgogames.se";
			brand.emailLink = "spel_";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "se";
			addBrand(brand);			
			
			// Spela.se - Swedish
			brand = new Brand();
			brand.site_id = 44;
			brand.domain = "www.spela.se";
			brand.emailLink = "spel_";
			brand.preferedLanguage = "se";
			brand.portalGroup = PortalGroup.FAMILY;
			addBrand(brand);			
						
			// Giocaregratis - Italian
			brand = new Brand();
			brand.site_id =106;
			brand.domain = "www.giocaregratis.it";
			brand.emailLink = "gioco";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "it";
			addBrand(brand);			
			
			// Gioco.it - Italian
			brand = new Brand();
			brand.site_id = 15;
			brand.domain = "www.gioco.it";
			brand.emailLink = "gioco";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "it";
			addBrand(brand);			
			
			// girlsgogames.it - Italian
			brand = new Brand();
			brand.site_id = 99;
			brand.domain = "www.girlsgogames.it";
			brand.emailLink = "gioco";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "it";
			addBrand(brand);			
			
			// zapjuegos.com - Spanish
			brand = new Brand();
			brand.site_id = 97;
			brand.domain = "www.zapjuegos.com";
			brand.emailLink = "juego";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "es";
			addBrand(brand);			
			
			// juegos.com - Spanish
			brand = new Brand();
			brand.site_id = 86;
			brand.domain = "www.juegos.com";
			brand.emailLink = "juego";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "es";
			addBrand(brand);
						
			// juegosdechicas.com - Spanish
			brand = new Brand();
			brand.site_id = 96;
			brand.domain = "www.juegosdechicas.com";
			brand.emailLink = "juego";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "es";
			addBrand(brand);
				
			// girlsgogames.es - Spanish		
			brand = new Brand();
			brand.site_id = 122;
			brand.domain = "www.girlsgogames.es";
			brand.emailLink = "juego";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "es";
			addBrand(brand);
							
			// juegos.com.mx - Mexico
			brand = new Brand();
			brand.site_id = 125;
			brand.domain = "www.juegos.mx";
			brand.emailLink = "juego";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "es";
			addBrand(brand);
			
			// juegosdechicas.mx - Mexico
			brand = new Brand();
			brand.site_id = 126;
			brand.domain = "www.juegosdechicas.mx";
			brand.emailLink = "juego";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "es";
			addBrand(brand);
			
			// juegos.com.ar - Argentina
			brand = new Brand();
			brand.site_id = 127;
			brand.domain = "www.juegos.com.ar";
			brand.emailLink = "juego";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "es";
			addBrand(brand);
			
			// juegosdechicas.com.ar - Argentina
			brand = new Brand();
			brand.site_id = 128;
			brand.domain = "www.juegosdechicas.com.ar";
			brand.emailLink = "juego";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "es";
			addBrand(brand);
			
			// Clickjogos.com - Brazilian
			brand = new Brand();
			brand.site_id = 91;
			brand.domain = "www.clickjogos.com";
			brand.emailLink = "jogo";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "br";
			addBrand(brand);
						
			// girlsgogames.com.br - Brazilian
			brand = new Brand();
			brand.site_id = 101;
			brand.domain = "www.girlsgogames.com.br";
			brand.emailLink = "jogo";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "br";
			addBrand(brand);			
			
			// Ojogos.com.br - Brazillian
			brand = new Brand();
			brand.site_id = 50;
			brand.domain = "www.ojogos.com.br";
			brand.emailLink = "jogo";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "br";
			addBrand(brand);		
			
			// Games.co.id - Indonesian
			brand = new Brand();
			brand.site_id = 55;
			brand.domain = "www.games.co.id";
			brand.emailLink = "permainanme";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "id";
			addBrand(brand);			
			
			// Flashgames.ru - russian##
			brand = new Brand();
			brand.site_id = 105;
			brand.domain = "www.flashgames.ru";
			brand.emailLink = "igra";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "ru";
			addBrand(brand);
						
			// girlsgogames.ru - Russian
			brand = new Brand();
			brand.site_id = 104;
			brand.domain = "www.girlsgogames.ru";
			brand.emailLink = "igra";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "ru";
			addBrand(brand);
						
			// Ourgames.ru - russian
			brand = new Brand();
			brand.site_id = 103;
			brand.domain = "www.ourgames.ru";
			brand.emailLink = "igra";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "ru";
			addBrand(brand);
			
					
			// Game.co.in - English - UK
			brand = new Brand();
			brand.site_id = 24;
			brand.domain = "www.game.co.in";
			brand.emailLink = "game";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "in";
			addBrand(brand);			
			
			
			/*
			// girlsgogames.in - English - UK
			brand = new Brand();
			brand.site_id = 115;
			brand.domain = "www.girlsgogames.in";
			brand.emailLink = "/game/";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "in";
			addBrand(brand);
			*/
			
			/*		
			// Asoyun.com - Turkish	
			brand = new Brand();
			brand.site_id = 116;
			brand.domain = "www.asoyun.com";
			brand.emailLink = "/oyun/";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "tr";
			addBrand(brand);			
			*/
			
			/*
			// girlsgogamestr.com - Turkish
			brand = new Brand();
			brand.site_id = 114;
			brand.domain = "www.girlsgogamestr.com";
			brand.emailLink = "/oyun/";
			brand.portalGroup = PortalGroup.GIRL;
			brand.preferedLanguage = "tr";
			addBrand(brand);				
			*/
			
			/* REMOVED
			// Oyunlar123.com - Turkish
			brand = new Brand();
			brand.site_id = 117;
			brand.domain = "www.oyunlar123.com";
			brand.emailLink = "/oyun/";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "tr";
			addBrand(brand);			
			*/
			/*
			// Game.com.my - Malaysian
			brand = new Brand();
			brand.site_id = 118;
			brand.domain = "www.game.com.my";
			brand.emailLink = "/permainan_/";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "my";
			addBrand(brand);			
			*/
			
			// Ojogos.pt - Portuguese
			brand = new Brand();
			brand.site_id = 87;
			brand.domain = "www.ojogos.pt";
			brand.emailLink = "jogo";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "pt";
			addBrand(brand);				
			
			/* REMOVED
			// Laro.com.ph - English - UK
			brand = new Brand();
			brand.site_id = 119;
			brand.domain = "www.laro.com.ph";
			brand.emailLink = "/game/";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "en_uk";
			addBrand(brand);				
			*/
			
			// Egames.jp - Japanese	
			brand = new Brand(); 
			brand.site_id = 120;
			brand.domain = "www.egames.jp";
			brand.emailLink = "game";
			brand.portalGroup = PortalGroup.TEENS;
			brand.preferedLanguage = "jp";
			addBrand(brand);
			
			// Arabic - www.dailygame.com
			brand = new Brand(); 
			brand.site_id = 121;
			brand.domain = "www.dailygame.com";
			brand.emailLink = "/game/";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "en_us";
			addBrand(brand);
			
			// Zapapa - www.zapapa.com
			brand = new Brand(); 
			brand.site_id = 123;
			brand.domain = "www.zapapa.com";
			brand.emailLink = "game";
			brand.portalGroup = PortalGroup.ZAPAPA;
			brand.preferedLanguage = "en_us";
			addBrand(brand);
			
			// Zapapa - www.zapapa.nl (used on hyves channel)
			brand = new Brand();
			brand.site_id = 124; // Jorrit: created placement site_id, since nobody can tell what this is for
			brand.domain = "www.zapapa.nl";
			brand.emailLink = "game";
			brand.portalGroup = PortalGroup.HYVES;
			brand.preferedLanguage = "nl";
			addBrand(brand);
			
			brand = new Brand();
			brand.site_id = 0;
			brand.domain = "gamedev.dev.spilgames.com";
			brand.portalGroup = PortalGroup.FAMILY;
			brand.preferedLanguage = "en_us";
			addBrand(brand);
						
		} 
		
		public static function hasDomain(domain:String) : Boolean
		{
			return brands_by_domain[domain] != null;
		}
		
		public static function getBrandByDomain(domain:String) : Brand
		{
			return brands_by_domain[domain];
		}
		public static function getBrandByID(id:Number) : Brand
		{
			return brands_by_id[id];
		}
						
		private static function addBrand(brand:Brand) : Brand
		{
			if(brands_by_domain[brand.domain]){
				trace("ERROR: Attempting to add duplicate brand by domain: " + brand.domain);
			} else {
				brands_by_domain[brand.domain] = brand;
			}
			if(brands_by_id[brand.site_id]){
				trace("ERROR: Attempting to add duplicate brand by id: " + brand.site_id);
			} else {
				brands_by_id[brand.site_id] = brand;
			}
			return brand;		
		}
		
		public static function getBrandsArray() : Array
		{
			var a:Array = new Array();
			for each(var b:Brand in brands_by_domain){
				a.push(b);
			}
			return a;
		}
		
		public static function exportXML() : XML
		{
			var xml:XML = <portals />;
			for each(var p:Brand in brands_by_domain){
				xml.appendChild(p.exportXML());
			}
			return xml;
			
		}

	}
}