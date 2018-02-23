package spill.localisation
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class BrandingLogoProxy extends MovieClip
	{
		public function BrandingLogoProxy()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
			
			if (stage)
			{
				added();
			}
		}
		
		private function added(e:Event = null):void
		{
			// Replace contents with branding logo
			var n:int = numChildren;
			while (--n > -1)
			{
				removeChildAt(0);
			}
			
			var brandingLogo:BrandingLogo = new BrandingLogo();
			addChild(brandingLogo);
			
		}
	}
}