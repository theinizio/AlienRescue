package spill.localisation
{
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * Simple component for placing the Spil Game company link in your game.
	 */
	public class SpilGamesLink extends SimpleButton
	{
		public function SpilGamesLink()
		{
			super();
			addEventListener(MouseEvent.CLICK, buttonClicked);
		}
		
		private function buttonClicked(e:MouseEvent) : void
		{
			navigateToURL(new URLRequest(SpilGame.getSpilCompanyLink()), "_blank");
		}
		
	}
	
}