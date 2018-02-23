package spill.localisation
{
	import flash.xml.XMLNode;
	
	
	/**
	 * This class contains static identifiers for portal group categories.
	 * 
	 * @see SpilGame#initialise()
	 */
	public class PortalGroup
	{
		
		/**
		 * Family Games Category
		 */		
		public static const FAMILY:uint = 0;
		
		/**
		 * Teens Games Category
		 */	
		public static const TEENS:uint = 1;
		
		/**
		 * Girl Games Category
		 */	
		public static const GIRL:uint = 2;

		/**
		 * Young Adults Games Category
		 */	
		public static const YOUNG_ADULTS:uint = 3;
		
		/**
		 * Zapapa Games Category
		 */	
		public static const ZAPAPA:uint = 4;
		
		/**
		 * Zapapa Games Category on Hyves.
		 */
		public static const HYVES:uint = 5;
		
		/**
		 * @private
		 */	
		public static const NONE:uint = 6;
		
		/**
		 * Returns a 
		 */
		public static function getName(id:int) : String
		{
			return channelNames[id];
		}
		
		public static function exportXML() : XMLNode
		{
			var xml:XMLNode = new XMLNode(1,"channels");
			for(var i:int=0;i<5;i++){
			
				var n:XMLNode = new XMLNode(1, "channel");
				n.attributes.name = channelNames[i];
				n.attributes.id = i;
				xml.appendChild(n);
				//xml.appendChild(l.exportXML());
				
			}
			return xml;
		}
		
		public static const channelNames:Array = ["family", "tween", "girl", "teen", "zapapa", "hyves"];
		public static const backgroundColors:Array = [0xFFFFFF, 0xFFFFFF, 0xFF77BB, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF];
		
	}
}