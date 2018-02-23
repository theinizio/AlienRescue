/*
 Legal
*/
package spill.localisation
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * This component is the Language Selection ComboBox, should be placed on stage 
	 * (either in the authoring environment or in code), it automatically updates 
	 * and switch languages based on user input.
	 * 
	 * @author Sjoerd Schoneveld
	 */	
	public class LanguageSelectBox extends MovieClip
	{
		
		use namespace spil_internal;
		private var popup:MovieClip;
		private var flag:MovieClip;
		private var languageName_text:TextField;
		private var mc:MovieClip;
		
		public function LanguageSelectBox()
		{

			trace("new langselecbox");
			
			super();
			if (numChildren > 0) {
				removeChildAt(0);
			}
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, removed, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
			
			Languages.initialize();
			
			popup = new LanguageSelectPopup_mc();
			
			x = Math.round(x);
			y = Math.round(y);
			
			popup.y = -Math.floor(popup.height) + 1;			
			popup.visible = false;
			addChild(popup);
			
			mc = new LanguageSelectBox_mc();
			addChild(mc);
			flag = mc.flag;
			languageName_text = mc.languageName_text;
			
			if(stage) added();
			
			init();
			
			languageChanged();
			
		}
		
		
		public function init() : void
		{
			trace("initselectbox");

			var btnArray : Array = new Array( popup.l_br, popup.l_de, popup.l_en_us, popup.l_fr, popup.l_in, popup.l_jp, popup.l_pt, popup.l_ru, popup.l_ar, popup.l_cn, popup.l_en_uk, popup.l_es, popup.l_id, popup.l_it, popup.l_nl, popup.l_pl, popup.l_se, popup.l_es_mx, popup.l_es_ar);

			//for(var i:int=0;i<popup.numChildren;i++){
			for(var i:int=0;i<btnArray.length;i++){


				var btn:MovieClip = MovieClip(btnArray[i]);

				if (btn){
					btn.addEventListener(MouseEvent.CLICK, itemClicked, true, 0, true);
					btn.flag.gotoAndStop(btn.name.substr(2));
					btn.flag.mouseEnabled = false;
					btn.text.mouseEnabled = false;
					//btn.mouseChildren = false; 
	
					var lang:Language = Languages.getLanguage(btn.name.substr(2));
					if(lang){
						btn.text.text = lang.displayAcronim;
					} else {
						trace("Error, '" + btn.name.substr(2) + "' language not found");
					}
				}else{
						trace("Error, btn number '"+i+"' is not a MovieClip or there is no button '"+btnArray[i]+"'");
				}
				//btn.name.substr(2));
			}		
		}
		
		private function itemClicked(e:MouseEvent) : void
		{
			SpilGame.changeLanguage(e.currentTarget.name.substr(2));
			popup.visible = false;
		}
		
		private function mouseOver(e:MouseEvent) : void
		{
			popup.visible = true;
		}
		
		private function mouseOut(e:MouseEvent) : void
		{
			popup.visible = false;
		}
		
		private function added(e:Event = null) : void
		{
			trace("addedselebnox");
			SpilGame.addEventListener("languageChanged", languageChanged, false, 0, true);
		}
		
		private function removed(e:Event) : void
		{
			SpilGame.removeEventListener("languageChanged", languageChanged);
		}
		
		private function languageChanged(e:Event = null) : void
		{
			if(SpilGame.currentLanguage){
				
				// Check if currentLanguage name is 'nl' and portalGroup is Hyves
				if (SpilGame.portalGroup == PortalGroup.HYVES && SpilGame.currentLanguage.name == "nl")
				{
					this.visible = false;
					return;
				}
				else
				{
					this.visible = true;
				}
				
				flag.gotoAndStop(SpilGame.currentLanguage.name);
				languageName_text.text = SpilGame.currentLanguage.displayName;//name;
				languageName_text.embedFonts = SpilGame.currentLanguage.embedInputFonts;
				
			}
		} 
		
		[Inspectable (name = "Popup Location", enumeration="top,bottom", defaultValue = "top")]		
		public function set popupLocation(v:String) : void
		{
			trace("popupLocation = " + v);
			if(v == "bottom"){
				popup.y = Math.floor(mc.height);
			} else {
				popup.y = -Math.floor(mc.height) + 1;
			}
		}
		
		
	}
}