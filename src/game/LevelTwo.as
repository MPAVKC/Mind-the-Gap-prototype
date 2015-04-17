package game
{
	import game.GameLevels;
	import gButtons.CheckButton;
	import Assets;
	import gtools.Background;
	import net.flashpunk.FP;
	/** Level 2 of the game.
	 * 
	 * @author ...
	 */
	public class LevelTwo extends GameLevels 
	{
		public function LevelTwo()
		{
			super();
			
			this.theTime = 7;
		}
		
		override public function begin():void 
		{
			
			add(new Background(Assets.BOSTONBACKGROUND));
			
			super.begin();
			this.timer.start();
			trace("LevelTwo class: Timer from level two has started...");
			add(new Diamond(650, 100));
			
			add(new GameCoin(200, 400));
			add(new GameCoin(400, 400));
		}
	}
}