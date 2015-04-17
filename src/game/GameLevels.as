package game 
{
	import gstatus.Clock;
	import gstatus.HPBar;
	import gtools.Background;
	import net.flashpunk.FP;
	import gstatus.CoinsCounter;
	import gButtons.NeonButton;
	import net.flashpunk.World;
	import flash.ui.MouseCursor;
	import net.flashpunk.utils.Input;
	import gmenu.Menu;
	
	import gmenu.Mediator;
	import flash.events.Event;
	
	/**
	 * Base for the all game levels
	 * 
	 * @author A
	 */
	public class GameLevels extends World
	{
		private var shop:NeonButton;
		private var coins:CoinsCounter;
		protected var timer:Clock;
		private var quit:NeonButton;
		private var hp:HPBar;
		protected var mediator:Mediator;
		
		private var player:Player;
		
		protected var theTime:int = 0;
		
		public function GameLevels(/*time:int*/)
		{
			//theTime = timer;
		}
		
		override public function begin():void 
		{
			super.begin();
			mediator = new Mediator();
			
			player = new Player();
			player.x = 50;
			player.y = 500;
			add(player);
			
			hp = new HPBar(15, 10, 100, 200, 25);
			add(hp);
			
			coins = new CoinsCounter(15, 60, "x ", 150, 25);
			add(coins);
			
			timer = new Clock(300, 10, "Time: 0 min 0 sec", 290, 25, theTime);
			add(timer);
			
			shop = new NeonButton(685, 10, "Shop", 100, 35, shopClick);
			add(shop);
	
			
			quit = new NeonButton(685, 60, "Quit", 100, 35, menuClick, 0xFFFFFF, 0xB990F0, 0xFFFFFF, 0xF6C7CD);
			add(quit);
			
			start();
			
		}
		
		public function menuClick():void
		{
			trace("GameLevels class: Quit button has been clicked");
			FP.world = new Menu("Mind the Gap");
			
		}
		
		public function shopClick():void
		{
			trace("GameLevels class: Shop button has been clicked");
		}
		
		//the update method each world should have so the mouse cursor adapts correctly
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			
			super.update();
		}
		
		public function start():void
		{
			FP.stage.addEventListener(Event.ENTER_FRAME, timerHandler);
			
		}
		
		public function timerHandler(event:Event):void 
		{
			if (mediator.gameOver) {
				trace("GameLevels class: Game Over...");
				FP.world = new GameOver();
				stop();
			}
			
			if (mediator.reachDestination)
			{
				trace("level one complete: " + mediator.level1Complete);
				if (mediator.level1Complete)
				{
					trace("GameLevels class: Congratulatory message for the completion of level one has been created...");
					mediator.level1Complete = false;
					mediator.reachDestination = false;
					//mediator.theLevel = 2;
					stop();
					mediator.game_data.data.level1Time = mediator.game_data.data.tempTime;
					FP.world = new CongratulatoryMessage(Assets.TRAINSTATION);
					
				}
				trace("level one complete: " + mediator.level2Complete);
				if (mediator.level2Complete)
				{
					trace("GameLevels class: Congratulatory message for the completion of level two has been created...");
					mediator.level2Complete = false;
					mediator.reachDestination = false;
					//mediator.theLevel = 3;
					stop();
					mediator.game_data.data.level2Time = mediator.game_data.data.tempTime;
					FP.world = new CongratulatoryMessage(Assets.AIRPORT);
					
				}
				trace("level one complete: " + mediator.level3Complete);
				if (mediator.level3Complete)
				{
					trace("GameLevels class: Congratulatory message for the completion of level three has been created...");
					mediator.gotoscores = true;
					mediator.reachDestination = false
					stop();
					mediator.game_data.data.level3Time = mediator.game_data.data.tempTime;
					FP.world = new CongratulatoryMessage(Assets.LON);

				}
				mediator.theLevel += 1;
				
			}
			
		}
		
		public function stop():void 
		{
			FP.stage.removeEventListener(Event.ENTER_FRAME, timerHandler);
			timer.stop();
			trace("GameLevels class: Timer has been stopped...");
		}
		
	}
}