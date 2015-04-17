package game
{
	import game.GameLevels;
	import Assets;
	import gtools.Background;
	/**
	 * Game level 3.
	 * 
	 * @author ...
	 */
	public class LevelThree extends GameLevels 
	{
		public function LevelThree()
		{
			super();
			
			this.theTime = 10;
		}
		
		override public function begin():void 
		{
			
			add(new Background(Assets.LEV));
			
			super.begin();
			
			this.timer.start();
			trace("LevelTwo class: Timer from level three has started...");
			add(new GameCoin(200, 470));
			add(new GameCoin(400, 470));
			add(new Ticket(650, 460));
			
		}
		
	}
}