package game
{
	import Assets;
	import gtools.Background;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import flash.ui.MouseCursor;
	import gButtons.EndButton;
	import net.flashpunk.FP;
	import gmenu.Menu;
	import gmenu.Mediator;
	
	/** Screen used when the game is over.
	 * 
	 * @author A
	 */
	public class GameOver extends World
	{
		private var playAgain:EndButton;
		private var quit_to_menu:EndButton;
		
		private var mediator:Mediator;
		public function GameOver()
		{
			super();
			mediator = new Mediator;
			add(new gtools.Background(Assets.GAMEOVER));
			playAgain = new EndButton(200, 500, "Play Again", 150, 50, playAgainClick)
			add(playAgain);
			quit_to_menu = new EndButton(450, 500, "Quit to Menu", 150, 50, menuButtonClick);
			add(quit_to_menu);
		}
		
		//the update method each world should have so the mouse cursor adapts correctly
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			
			super.update();
		}
		
		public function menuButtonClick():void
		{
			trace("GaverOver class: Menu button has been clicked..");
			FP.world = new Menu("Mind the Gap");
			
		}
		
		public function playAgainClick():void
		{
			trace("GameOver class: Play Again button has been clicked..");
			if (mediator.theLevel == 1)
			{
				trace("GameOver class: Level one has been reinitiated...");
				FP.world = new LevelOne();
				mediator.game_data.clear();
				
			}
			else if (mediator.theLevel == 2)
			{
				trace("GameOver class: Level two has been reinitiated...");
				FP.world = new LevelTwo();
			}
			else 
			{
				trace("GameOver class: Level three has been reinitiated...");
				FP.world = new LevelThree();
			}
			
			
		}
		
		
	}
	
}