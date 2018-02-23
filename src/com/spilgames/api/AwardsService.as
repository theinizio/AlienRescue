/* 
Copyright (c) 2010 SPIL GAMES
*/
package com.spilgames.api
{
	/**
	 * The AwardsService provides an easy to use interface to notify the
	 * Spil Games services when a player achieves an award in your game.
	 * 
	 * @example The following code shows how to setup an connection with
	 * the Spil Games services and submit an award for your game.
	 * 
	 * <listing version="3.0">
	 * import com.spilgames.api.AwardsService;
	 * import com.spilgames.api.SpilGamesServices;
	 * 
	 * // First setup a connection with the Spil Games services
	 * var spilGamesServices:SpilGamesServices = SpilGamesServices.getInstance();
	 * spilGamesServices.addEventListener("servicesReady", onServicesReady);
	 * spilGamesServices.addEventListener("servicesFailed", onServicesFailed);
	 * spilGamesServices.connect(this);
	 * 
	 * function onServicesReady(e:Event):void
	 * {
	 *     trace("SpilGamesServices connection ready");
	 * 
	 *     // Now we can submit an award
	 *     AwardsService.submitAward("award1");
	 * }
	 * 
	 * function onServicesFailed(e:ErrorEvent):void
	 * {
	 *     trace("SpilGamesServices connection failed due to", e.text);
	 * }
	 * </listing>
	 */
	public class AwardsService
	{
		/**
		 * Notifies the Spil Games services the user has achieved an award in your
		 * game. An optional callback can be specified in order to receive
		 * notifications and data regarding the sent request. This callback is both
		 * used upon success or failure.
		 * 
		 * <p>The callback function takes two arguments and must be defined as
		 * follows:<br/></p>
		 * <code>mySubmitAwardCallback(callbackID:int, data:Object):void</code></p>
		 * 
		 * <p>The first argument is an <code>int</code> identifying the call which
		 * triggers the callback. This identifier is returned when you call
		 * <code>submitAward</code>.</p>
		 * 
		 * <p>The second argument is an <code>Object</code> holding data retrieved
		 * from the service, or an error message. The structure of the data is shown
		 * in the exmaple below:
		 * <listing version="3.0">
		 * function mySybmitAwardCallback(callbackID:int, data:Object):void
		 * {
		 *     // data.errorMessage signals an error
		 *     if (data.errorMessage)
		 *     {
		 *         trace(data.errorMessage);
		 *     }
		 *     else
		 *     {
		 *         // data.xml holds XML returned from the service.
		 *         trace(data.xml);
		 *     }
		 * }
		 * </listing>
		 * 
		 * @param awardTag String specifying the award the user has achieved. This
		 *   tag <b>must</b> correspond to a tag name as send via the agreement in
		 *   order for it to work correctly.
		 * @param callback [optional] Function which handles any data received from
		 *   the server. The function must be in the form
		 *   <code>function functionName(callbackID:int, data:Object):void;</code>
		 * 
		 * @return Returns a positive numerical id to identify which request calls
		 *   the given callback, or <code>SpilGamesServices.INVALID_ID</code> when
		 *   the request fails immediately.
		 */
		public static function submitAward(awardTag:String, callback:Function = null):int
		{
			return SpilGamesServices.getInstance().send("Awards", "submitAward", callback, {
				tag:awardTag,
				userName:User.getUserName(),
				userHash:User.getUserHash()
			});
		}
	}
}