package spill.localisation
{
	import flash.xml.XMLNode;
	
	
	/**
	 * @private
	*/
	public class Brand
	{
		
		public var domain:String;
		public var site_id:uint;
		public var moreLink:String = "";
		public var emailLink:String = "game";
		public var emailPage:String;
		public var id:Number;
		public var name:String;
		public var portalGroup:uint;
		public var useGoogleAnalitics:Boolean = true;
		public var hasSendToFriendLink:Boolean = true;
		
		public var preferedLanguage:String = "";
		public var isExternal:Boolean = false;
		public var hostingDomain:String = "";
		
		
		public function Brand()
		{
		}
		

		public function getMoreGamesLink(gameName:String, isExternal:Boolean, externalDomain:String = "", term:String = "" ) : String
		{
			// get main portal domain
			var l:String = "http://" + domain;
			
			// add more games path
			l += "/" + moreLink;
			
			if(useGoogleAnalitics){
				
				// Add source variable
				l += "?utm_medium=brandedgames_" + (isExternal ? "external" : "internal");
				
				// Add medium variable (game name)
				l += "&utm_campaign=" + gameName;
				
				// Add domain for external files
				//if(isExternal && externalDomain != ""){
				
				externalDomain = stripSubDomain(externalDomain);
				//trace("externalDomain", externalDomain);
				if(externalDomain == "localhost") externalDomain = "offline_play";
				//trace("externalDomain", externalDomain);
				l += "&utm_source=" + externalDomain;
				
				// Add optional term variable
				if(term != "" && term != null){
					l += "&utm_content=" + term; 
				}
			}
			
			// return link
			return l;
		}
		
		/**
		 * Returns the send to friend link
		*/				
		public function getSendToFriendLink (gameName:String, 
											 emailPage:String, 
											 isExternal:Boolean,
											 externalDomain:String = "") : String
		{

			if(!hasSendToFriendLink){
				return getMoreGamesLink(gameName, isExternal);
			}
			
			// get main portal domain
			var l:String = "http://" + domain;
			
			// add more games path
			l += "/" + emailLink + "/" + emailPage;
			
			if(useGoogleAnalitics){
				
				// Add source variable
				l += "?utm_medium=brandedgames_" + (isExternal ? "external" : "internal");
				
				// Add medium variable (game name)
				l += "&utm_campaign=" + gameName;
				
				// Add domain for external files
				externalDomain = stripSubDomain(externalDomain);
				if(externalDomain == "localhost") externalDomain = "offline_play"; 
				l += "&utm_source=" + externalDomain; 
				
				l += "&utm_content=send_to_friend";
			}
			// Add send to friend term

			
			// return link
			return l;
		}
		
		/**
		 * Returns the feature promotion link
		*/			
		public function getPromotionLink(gameName:String, emailPage:String, isExternal:Boolean, externalDomain:String = "", term:String = "") : String
		{
			// get main portal domain
			var l:String = "http://" + domain;
			
			// add game path
			l += "/" + emailLink + "/" + emailPage;
			
			if(useGoogleAnalitics){
				
				// Add source variable
				l += "?utm_medium=brandedgames_" + (isExternal ? "external" : "internal");
				
				// Add medium variable (game name)
				l += "&utm_campaign=" + gameName;
				
				// Add domain for external files
				//if(isExternal && externalDomain != ""){
				
				externalDomain = stripSubDomain(externalDomain);
				trace(externalDomain);
				if(externalDomain == "localhost") externalDomain = "offline_play"; 
				l += "&utm_source=" + externalDomain;
				
				// Add optional term variable
				if(term != "" && term != null){
					l += "&utm_content=" + term; 
				}
			}
			
			// return link
			return l;			
		}
		
		public function get backgroundColor() : uint
		{
			return PortalGroup.backgroundColors[portalGroup];
		}
		
		public function exportXML() : XML
		{
			var xml:XML = <portal />;

			xml.@id = site_id;
			xml.@language = preferedLanguage;
			xml.@channel = portalGroup;
			
			var g:XML = <domain />;
			g.appendChild(new XMLNode(3, domain));
			xml.appendChild(g);			
			
			if(moreLink){	
				var m:XML = <more_games_path />;
				m.appendChild(new XMLNode(3, moreLink));
				xml.appendChild(m);
			}
			
			g = <game_path />;
			g.appendChild(new XMLNode(3, emailLink));
			xml.appendChild(g);
			
			if(!useGoogleAnalitics){
				xml.attributes.noGoogleAnalitics = true;
			} 
			if(!hasSendToFriendLink){
				xml.attributes.noSendToFriendLink = true;
			}	
			return xml;
		}
		
		public function importXML(xml:XMLNode) : void
		{
			
		}
		
			
		// ouch
		private static const topLevelDoubles:String = "ac.cn,ac.jp,ac.uk,ad.jp,adm.br,adv.br,agr.br," + 
				"ah.cn,am.br,arq.br,art.br,asn.au,ato.br,av.tr,bel.tr,bio.br,biz.tr,bj.cn,bmd.br," + 
				"cim.br,cng.br,cnt.br,co.at,co.jp,co.uk,com.au,com.br,com.cn,com.eg,com.hk,com.mx," + 
				"com.ru,com.tr,com.tw,conf.au,cq.cn,csiro.au,dr.tr,ecn.br,edu.au,edu.br,edu.tr," + 
				"emu.id.au,eng.br,esp.br,etc.br,eti.br,eun.eg,far.br,fj.cn,fm.br,fnd.br,fot.br," + 
				"fst.br,g12.br,gb.com,gb.net,gd.cn,gen.tr,ggf.br,gob.mx,gov.au,gov.br,gov.cn," + 
				"gov.hk,gov.tr,gr.jp,gs.cn,gx.cn,gz.cn,ha.cn,hb.cn,he.cn,hi.cn,hk.cn,hl.cn,hn.cn," + 
				"id.au,idv.tw,imb.br,ind.br,inf.br,info.au,info.tr,jl.cn,jor.br,js.cn,jx.cn,k12.tr," + 
				"lel.br,ln.cn,ltd.uk,mat.br,me.uk,med.br,mil.br,mil.tr,mo.cn,mus.br,name.tr,ne.jp," + 
				"net.au,net.br,net.cn,net.eg,net.hk,net.lu,net.mx,net.ru,net.tr,net.tw,net.uk," + 
				"nm.cn,no.com,nom.br,not.br,ntr.br,nx.cn,odo.br,oop.br,or.at,or.jp,org.au,org.br," + 
				"org.cn,org.hk,org.lu,org.ru,org.tr,org.tw,org.uk,plc.uk,pol.tr,pp.ru,ppg.br,pro.br," + 
				"psc.br,psi.br,qh.cn,qsl.br,rec.br,sc.cn,sd.cn,se.com,se.net,sh.cn,slg.br,sn.cn," + 
				"srv.br,sx.cn,tel.tr,tj.cn,tmp.br,trd.br,tur.br,tv.br,tw.cn,uk.com,uk.net,vet.br," + 
				"wattle.id.au,web.tr,xj.cn,xz.cn,yn.cn,zj.cn,zlg.br,co.nr,co.nz,com.fr,com.ph,com.ar," +
				"com.id,com.in";

		public static function stripSubDomain(domain:String) : String
		{
			if(!domain) return "";
			var p:Array = domain.split(".");
			if(p.length <= 2){
				return domain;
			} else {
				p = p.reverse();
				if(topLevelDoubles.indexOf(p[1] + "." + p[0] + ",") > 0){
					return p[2] + "." + p[1] + "." + p[0];
				} else {
					return p[1] + "." + p[0];
				}
			}
		}
		

		
		private function get utm_source() : String
		{
			return "utm_source=brandedgames_" + (isExternal ? "external" : "internal");
		}
		
		
		private function get utm_term() : String
		{
			return "utm_term=";
		}
		
		private function get utm_campaign() : String
		{
			if(isExternal) {
				return "utm_campaign=" + hostingDomain;
			} else {
				return "";
			}
		}
		

	}
}