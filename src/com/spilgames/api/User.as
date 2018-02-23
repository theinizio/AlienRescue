/* 
Copyright (c) 2010 SPIL GAMES
*/
package com.spilgames.api
{
	import flash.display.DisplayObject;

	/**
	 * The User class provides easy to use methods to retrieve information about the
	 * status of the user on a Spil Games portal.
	 */
	public class User
	{
		/**
		 * Returns whether or not the user currently playing is a guest. A user is signaled
		 * as guest when no user name or user hash are provided to the game.
		 * @returns <code>false</code> when the user is connected and contains valid 
		 */
		public static function isGuest():Boolean
		{
			var connection:* = SpilGamesServices.getInstance().connection;
			if (connection != null)
			{
				return connection.isGuest();
			}
			else
			{
				// Backwards compatible
				//trace("WARNING: SpilGamesServices connection not ready yet");
				
				var root:DisplayObject = SpilGamesServices.getInstance().root;
				if (root.loaderInfo != null)
				{
					var vars:Object = root.loaderInfo.parameters;
					return (!vars.username || vars.username == "" || !vars.hash || vars.hash == "");
				}
				else
				{
					return false;
				}
			}
		}
		
		/**
		 * Retrieves the user name of the user logged in, if any.
		 * 
		 * @return The user name of the user logged in when the connection has been
		 * established, or an empty String when the connection is not ready, or when
		 * the game is not running on a Spil Games site.
		 */
		public static function getUserName():String
		{
			var connection:* = SpilGamesServices.getInstance().connection;
			if (connection != null)
			{
				return connection.getUserName();
			}
			else
			{
				return "";
			}
		}
		
		/**
		 * Retrieves the hash of the user logged in on the Spil Games portal the game
		 * is running on.
		 * 
		 * <p>The hash is used for verification of the user on the server side of the
		 * services.</p>
		 * 
		 * @return The hash of the user logged in when the connection has been
		 * established, or an empty String when the connection is not ready, or when
		 * the game is not running on a Spil Games site.
		 */
		public static function getUserHash():String
		{
			var connection:* = SpilGamesServices.getInstance().connection;
			if (connection != null)
			{
				return connection.getUserHash();
			}
			else
			{
				return "";
			}
		}
	}
}