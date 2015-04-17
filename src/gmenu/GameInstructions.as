package gmenu
{
	import gtools.Background;
	/**
	 * Instructions on how to play this game.
	 * ...
	 * @author AKM
	 */
	public class GameInstructions extends Tutorial
	{
		public function GameInstructions(source:*) {
			super();
			
			add(new Background(source));
			
		}
	}
}