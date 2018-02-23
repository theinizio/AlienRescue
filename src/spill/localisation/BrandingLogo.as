package spill.localisation
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	/**
	 * This component displays a Spil Games portal branding logo. It
	 * automatically switches state if/when neccesary.
	 * 
	 * @author Sjoerd Schoneveld
	 */	
	public class BrandingLogo extends MovieClip
	{
		
		use namespace spil_internal;
		
		/**
		 * Constructor, creates a new BrandingLogo instance
		 */
		public function BrandingLogo()
		{			
			super();
			stop();
			mouseEnabled = false;
			mouseChildren = false;			
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, removed, false, 0, true);
			if(stage) added();
			brandingChanged();
		}
		
		
		private function added(e:Event = null) : void
		{
			SpilGame.addEventListener("brandingChanged", brandingChanged, false, 0, true);
			brandingChanged();
		}
		
		private function removed(e:Event) : void
		{
			SpilGame.removeEventListener("brandingChanged", brandingChanged);
		}
		
		private function brandingChanged(e:Event = null) : void
		{			
			if(SpilGame.currentBranding){
				gotoAndStop(SpilGame.currentBranding.domain);
			}
		}
		
		
		
		
	}
}