/* 
Copyright (c) 2010 SPIL GAMES
*/
package com.spilgames.api
{
	/**
	 * The ScoreService provides an easy to use interface for submitting scores to
	 * Spil Games services.
	 * 
	 * @example The following code shows how to setup an connection with
	 * the Spil Games services and submit a score for your game.
	 * 
	 * <listing version="3.0">
	 * import com.spilgames.api.ScoreService;
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
	 *     // Now we can submit a score
	 *     ScoreService.submitScore(10);
	 * }
	 * 
	 * function onServicesFailed(e:ErrorEvent):void
	 * {
	 *     trace("SpilGamesServices connection failed due to", e.text);
	 * }
	 * </listing>
	 */
	public class ScoreService
	{
		/**
		 * Submits a score to the Spil Games highscore service. An optional callback
		 * can be specified in order to receive notifications and data regarding the
		 * sent request. This callback is both used upon success or failure.
		 * 
		 * <p>The callback function takes two arguments and must be defined as
		 * follows:<br/></p>
		 * <code>mySubmitScoreCallback(callbackID:int, data:Object):void</code></p>
		 * 
		 * <p>The first argument is an <code>int</code> identifying the call which
		 * triggers the callback. This identifier is returned when you call
		 * <code>submitScore</code>.</p>
		 * 
		 * <p>The second argument is an <code>Object</code> holding data retrieved
		 * from the service, or an error message. The structure of the data is shown
		 * in the exmaple below:
		 * <listing version="3.0">
		 * function mySubmitScoreCallback(callbackID:int, data:Object):void
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
		 * @param score A numerical value for the score the user achieved. Currently
		 * @param callback [optional] Function which handles any data received from
		 *   the server. The function must be in the form
		 *   <code>function functionName(callbackID:int, data:Object):void;</code>
		 * 
		 * @return Returns a positive numerical id to identify which request calls
		 *   the given callback, or <code>SpilGamesServices.INVALID_ID</code> when
		 *   the request fails immediately.
		 */
		public static function submitScore(score:int, callback:Function = null):int
		{
			return SpilGamesServices.getInstance().send("Score", "submitScore", callback, {
				score:score,
				userName:User.getUserName(),
				userHash:User.getUserHash()
			});
		}
	}
}