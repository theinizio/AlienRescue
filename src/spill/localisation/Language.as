package spill.localisation
{
	import flash.xml.XMLNode;
	
	
	/**
	 * @private
	 */
	public class Language
	{
		
		
		public var name:String;
		public var dname:String;
		public var id:uint;
		public var portal_groups:Array;
		// Identifier used to obtain the language from the parsed Excell sheet
		// For instance Indonesian portals use en_uk, Mexican portals use es
		public var textLanguage:String;
		public var embedFonts:Boolean = true;
		public var embedInputFonts:Boolean = true;
		public var forceFont:String = null;
		public var bwcId:int;
		public var references:Array = [];
			
		public function Language(_name:String, _dname:String = null)
		{
			name = _name;
			dname = _dname;
			
			portal_groups = new Array();
		}
		
		
		public var displayName:String = "";
		//public function get displayName() : String
		//{
		//	return null;
		//}
		
		public function get displayAcronim() : String
		{
			return dname ? dname : name;
		}
		
		//public function get textLanguage
		
		// Family
		public function set p_family(portalDomain:String) : void
		{
			portal_groups[PortalGroup.FAMILY] = portalDomain;
		}
		public function get p_family() : String
		{
			return portal_groups[PortalGroup.FAMILY];
		}		
		
		// Tween
		public function set p_tween(portalDomain:String) : void
		{
			portal_groups[PortalGroup.TEENS] = portalDomain;
		}
		public function get p_tween() : String
		{
			return portal_groups[PortalGroup.TEENS];
		}			
			
		// Girl	
		public function set p_girl(portalDomain:String) : void
		{
			portal_groups[PortalGroup.GIRL] = portalDomain;
		}	
		public function get p_girl() : String
		{
			trace("Language", portal_groups[PortalGroup.GIRL]);
			return portal_groups[PortalGroup.GIRL];
		}			
		
		
		// Teen
		public function set p_teen(portalDomain:String) : void
		{
			portal_groups[PortalGroup.YOUNG_ADULTS] = portalDomain;
		}
		public function get p_teen() : String
		{
			return portal_groups[PortalGroup.YOUNG_ADULTS];
		}		
		
		// Zapapa
		public function set p_zapapa(portalDomain:String) : void
		{
			// todo ..
			portal_groups[PortalGroup.ZAPAPA] = portalDomain;
		}
		public function get p_zapapa() : String
		{
			//todo ..
			return portal_groups[PortalGroup.ZAPAPA];
			//return "";
		}
		
		// Hyves
		public function set p_hyves(portalDomain:String) : void
		{
			portal_groups[PortalGroup.HYVES] = portalDomain;
		}
		public function get p_hyves() : String
		{
			return portal_groups[PortalGroup.HYVES];
		}
		
		
		public function exportXML() : XMLNode
		{
			var xml:XMLNode = new XMLNode(1,"language");
			xml.attributes.name = name;
			if(textLanguage != null){
				xml.attributes.textLanguage = textLanguage;
			}
			if(references.length){
				xml.attributes.references = references.toString();
			}
			xml.attributes.id = bwcId;
			
			var n:XMLNode = new XMLNode(1,"display_name");	
			n.firstChild = new XMLNode(3, displayName);					
			xml.appendChild(n);
			

			
			//
			var cs:Array = [];
			var channels:Array = PortalGroup.channelNames;
			for(var i:int=0;i<channels.length;i++){
				cs.push(Brandings.getBrandByDomain(portal_groups[i]).site_id);
			}
			xml.attributes.channels = cs.join(",");
			//
			
			
			/*
			var portals:XMLNode = new XMLNode(1,"channels");
			n = new XMLNode(1,"girl");
			n.firstChild = new XMLNode(3, portal_groups[PortalGroup.GIRL]);
			portals.appendChild(n);
			n = new XMLNode(1,"family");
			n.firstChild = new XMLNode(3, portal_groups[PortalGroup.FAMILY]);
			portals.appendChild(n);
			n = new XMLNode(1,"tween");
			n.firstChild = new XMLNode(3, portal_groups[PortalGroup.TWEEN]);
			portals.appendChild(n);
			n = new XMLNode(1,"teen");
			n.firstChild = new XMLNode(3, portal_groups[PortalGroup.TEEN]);			
			portals.appendChild(n);
			xml.appendChild(portals)
			*/			

			
			
			return xml;			
		}
		
			
	}
	
}