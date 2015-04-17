package gmenu 
{
	import Assets;
	import gtools.Background;
	import net.flashpunk.FP;
	import flash.ui.MouseCursor;
	import net.flashpunk.utils.Input;
	import gButtons.BlueButton;
	import game.LevelOne;
	import game.LevelTwo;
	import game.LevelThree;
	
	
	/**
	 * Menu for the game
	 * 
	 * @author AKM
	 */
	public class Menu extends Screens
	{	
		// buttons for the menu
		private var playButton:BlueButton;
		private var tutorialButton:BlueButton;
		private var scoresButton:BlueButton;
		
		// lets the menu communicate inderectly with other classes
		private var mediator:Mediator;
		
		/**
		 * 
		 * @param	title: name of the game
		 */
		public function Menu(title:String) 
		{
			super(title, 0, 20);
		}
		
		override public function begin():void 
		{	
			add(new gtools.Background(Assets.MENU));
			super.begin();
			
			playButton = new BlueButton(175, 500, "Play", 100, 50, playButtonClick);
			tutorialButton = new BlueButton(350, 500, "Tutorial", 100, 50, tutorialButtonClick);
			scoresButton = new BlueButton(525, 500, "Scores", 100, 50, scoresButtonClick);
			
			mediator = new Mediator();
			mediator.gotoscores = false;
			
			add(playButton)
			add(tutorialButton)
			add(scoresButton)
			
		}
		
		/**
		 * the actions that happen when the play button is clicked 
		 */
		private function playButtonClick():void
		{	
			mediator.gameLevel();
			
			// gets the game level the user will play 
			var current_level:int = mediator.game_data.data.level;
			
			trace("Menu class: Play button has been clicked...");
			
			// determines the game level that will be played
			switch(current_level)
			{
				case 1:
					FP.world = new LevelOne();
					mediator.game_data.data.destination = "the 'Train Station'";
					trace("Menu class: Level one has started...");
					break;
				
				case 2:
					FP.world = new LevelTwo();
					mediator.game_data.data.destination = "Logan International Airport";
					trace("Menu class: Level two has started...");
					break;
				
				case 3:
					FP.world = new LevelThree();
					mediator.game_data.data.destination = "London, England'";
					trace("Menu class: Level three has started...");
					break;
					
			}
		}
		
		/**
		 * actions for the tutorial button
		 */
		private function tutorialButtonClick():void
		{
			trace("Menu class: Tutorial button has been clicked...");
			//ceates the tutorial screen
			FP.world = new GameInstructions(Assets.ZERO);
		}
		
		/**
		 * actions for the scores button
		 */
		private function scoresButtonClick():void
		{
			trace("Menu class: Scores button has been clicked...");
			// creates the scores screen
			FP.world = new Scores();
		}
		
	}
}