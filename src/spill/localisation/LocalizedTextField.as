package spill.localisation 
{
	import flash.events.Event;
	
	/**
	 * This is the Localised Textfield Component. It inherits all functionality 
	 * from the TextFieldFit component.
	 * 
	 * <p>Whenever the supplied text in this component contains text between curly 
	 * brackets (ie: '{identifier}') it will attempt to replace the text with a 
	 * localised version of that identifier string. The identifiers to use can 
	 * be found in the Excel localisation spreadsheet supplied by Spil Games.</p>
	 * 
	 * <p>If no matching identifier is found, or unavailable for the current language, 
	 * the string is not modified. The textfield can contain any text in addition to 
	 * the localised text and can contain any number of localised text identifiers.</p>
	 * 
	 * <p>It is not required to use this component for localising text, localised strings
	 * can be retrieved using <code>SpilGame.getString()</code></p>
	 * 
	 * <p>Beware using this component during frame based instantiation, as ActionScript 3 
	 * has problems with this</p>
	 * 
	 * 
	 * @see TextFieldfFit
	 * @see SpillGame#getString()
	 * 
	 * @author Sjoerd Schoneveld
	 */
	public class LocalizedTextField extends TextFieldFit
	{
		
		
		use namespace spil_internal;
		
		public function LocalizedTextField()
		{

			super();
			// Add event listener for added and removed from stage events
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, removed, false, 0, true);
			added();
			//text = originalText;
			
		}
		
		// Listenen for language changed events when the component is added to the stage
		private function added(e:Event = null) : void
		{
			SpilGame.addEventListener("languageChanged", languageChanged, false, 0, true);
			text = originalText;
			//if(!this.embedFonts){
			//	trace("embed fonts disabled for " + this + " in " + parent + " with text: " + text);
			//}
		}
		
		// Stop listenen for language changed events when the component removed from the stage
		private function removed(e:Event) : void
		{
			SpilGame.removeEventListener("languageChanged", languageChanged);
			
		}
		
		// Language changed event listener
		private function languageChanged(e:Event) : void
		{
			text = originalText;
			updateProperties();
		}
		
		private var originalText:String;
		
		/**
		 * @private
		 */
		override public function set text(value:String) : void
		{
			originalText = value;
			if(value is String){
				super.text = value.replace(regex, replaceFn);
			} else {
				super.text = "";
			}
            trace(super.text);
		}
		
		// Replacement pattern
		private var regex:RegExp = /{([^{}]*)}/g
		
		// Replacement function
		private function replaceFn() : String
		{	
			var str:String = SpilGame.getString(arguments[1]);
			if(!str || str == ""){
				return "{" + arguments[1] + "}";
			} else { 
				//str = str.replace(regex, replaceFn);
				return str;
			}
		}
		
	}
	
}