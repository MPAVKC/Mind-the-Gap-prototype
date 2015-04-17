package gmenu
{
	import adobe.utils.CustomActions;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author MKA
	 */
	public class Mediator
	{
		// for storing data locally
		public var game_data:SharedObject;
		
		public function Mediator() 
		{
			// creates the object on which the data will be stored
			game_data = SharedObject.getLocal('data');
			
		}
		
		/*
		 * checks whether any game level has been played
		 */
		public function gameLevel():void
		{
			// if no level has been played yet, then the player will 
			// start playing the first level 
			if (game_data.data.level == null)
			{
				game_data.data.level = 1;
			}
		}
		
		public function get theLevel():int
		{
			var level:int = game_data.data.level;
			return level;
		}
		
		public function set theLevel(setLevel:int):void
		{
			game_data.data.level = setLevel;
		}
		
		public function gameCoins():void
		{
			if (game_data.data.coins == null)
			{
				game_data.data.coins = 0;
			}
		}
		
		public function get thecoinsnum():int
		{
			gameCoins();
			var number_of_coins:int = game_data.data.coins;
			
			return number_of_coins;
		}
		
		public function set thecoinsnum(setCoinNum:int):void
		{
			var number_of_coins:int = game_data.data.coins;
			game_data.data.coins = number_of_coins + setCoinNum;
		}
		
		public function set reachDestination(destination:Boolean):void
		{
			game_data.data.reachdestination = destination;
		}
		
		public function get reachDestination():Boolean
		{
			var end_of_trip:Boolean = false;
			if (game_data.data.reachdestination)
			{
				end_of_trip = true;
			}
			
			return end_of_trip;
		}
		
		public function get theHP():int
		{
			var health_points:int = game_data.data.healthPoints;
			
			return health_points;
		}
		
		public function set theHP(setHP:int):void
		{
			var health_points:int = game_data.data.healthPoints;
			health_points = health_points + setHP;
			game_data.data.healthPoints = health_points;
			
			if (game_data.data.healthPoints > 100) {
				game_data.data.healthPoints = 100;
			}
			else {
				if (game_data.data.healthPoints < 0)
				{
					game_data.data.healthPoints = 0;
				}
			}
			
		}
		
		public function get gameOver():Boolean
		{
			var gameover:Boolean = false;
			if ((game_data.data.healthPoints == 0))
			{
				gameover = true;
				
			}
			if (game_data.data.timeRunOut)
			{
				gameover = true;
			}
			return gameover;
		}
		
		public function set level1Complete(complete:Boolean):void
		{
			game_data.data.level1 = true;
		}
		
		public function get level1Complete():Boolean
		{
			var levelcomplete:Boolean = false;
			if (game_data.data.level1 == true)
			{
				levelcomplete = true;
			}
			return levelcomplete;
		}
		
		public function set level2Complete(complete:Boolean):void
		{
			game_data.data.level2 = true;
		}
		
		public function get level2Complete():Boolean
		{
			var levelcomplete:Boolean = false;
			if (game_data.data.level2 == true)
			{
				levelcomplete = true;
			}
			return levelcomplete;
		}
		public function set level3Complete(complete:Boolean):void
		{
			game_data.data.level3 = true;
		}
		
		public function get level3Complete():Boolean
		{
			var levelcomplete:Boolean = false;
			if (game_data.data.level3 == true)
			{
				levelcomplete = true;
			}
			return levelcomplete;
		}
		
		public function set gotoscores(goto:Boolean):void
		{
			game_data.data.gotoScores = goto;
		}
		
		public function get gotoscores():Boolean
		{
			var go:Boolean = false;
			if (game_data.data.gotoScores)
			{
				go = true;
			}
			return go;
		}
		
		public function set timerunout(timeout:Boolean):void
		{
			game_data.data.timeRunOut = true;
		}
		
		public function get timerunout():Boolean
		{
			var timeout:Boolean = false;
			if (game_data.data.RunOut == true)
			{
				timeout = true;
			}
			return timeout;
		}
		
	}
	
}