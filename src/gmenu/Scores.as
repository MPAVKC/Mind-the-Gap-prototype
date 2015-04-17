package gmenu 
{
	import Assets;
	import gtools.Background;
	import net.flashpunk.FP;
	import gButtons.NavigationButton;
	
	/**
	 * Players' scores are displayed from highest to lowest on a formated 
	 * table.
	 * 
	 * @author AKM
	 */
	public class Scores extends Screens 
	{
		// button for returning to the main menu
		private var menu:NavigationButton;
		
		public function Scores() 
		{
			super("", 0, 10);
			
		}
		
		override public function begin():void 
		{
			// Screen background
			add(new Background(Assets.LONDONBACKGROUND));
			super.begin();
			
			menu = new NavigationButton(360, 500, "Menu", false, 80, 40, menuButtonClick)
			add(menu);
			
		}
		
		public function menuButtonClick():void
		{
			trace("Scores class: Menu button has been clicked...");
			FP.world = new Menu("Mind the Gap");
			
		}
	}
}