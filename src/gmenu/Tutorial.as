package gmenu 
{
	import Assets;
	import net.flashpunk.FP;
	import gButtons.NavigationButton;
	
	/**
	 * Use as a base for all the game instruction slides.
	 *  This class is a modification of the 'BaseShowcase' class 
	 *  authored by Abel Toy (Rolpege) [http://abeltoy.com/].
	 *  Not all the code from the original class is used on this class. 
	 * 
	 *   -^ Note: The name of variables or functions may 
	 *      have been changed. 
	 * 
	 * @author 
	 */
	public class Tutorial extends Screens 
	{
		private static var currentPage:int;
		private var instructions:Vector.<Tutorial>;
		
		// button for returning to the main menu
		private var menu:NavigationButton;
		
		public function Tutorial() 
		{
			super("TUTORIAL", 0, 10);
		}
		
		override public function begin():void 
		{
			// list of the game instruction slides
			instructions = new Vector.<Tutorial>;
			instructions.push(new GameInstructions(Assets.ZERO));
			instructions.push(new GameInstructions(Assets.ONE));
			instructions.push(new GameInstructions(Assets.TWO));
			instructions.push(new GameInstructions(Assets.THREE));
			instructions.push(new GameInstructions(Assets.FOUR));
			
			super.begin();
			
			// navigation buttons creation
			add(new NavigationButton(30, 450, "< Prev", false, 80, 40, changePage, currentPage - 1));
			
			var navLength:int = 40 * instructions.length + 10 * (instructions.length - 1);
			
			for (var i:int = 0; i < instructions.length; ++i)
			{
				add(new NavigationButton((FP.width - navLength) * 0.5 + 50 * i, 450, (i + 1).toString(), currentPage == i, 40, 40, changePage, i));
			}
			
			add(new NavigationButton(690, 450, "Next >", false, 80, 40, changePage, currentPage + 1));
			
			menu = new NavigationButton(360, 500, "Menu", false, 80, 40, menuButtonClick)
			add(menu);
			
		}
		
		protected function changePage(params:Object):void
		{
			currentPage = int(params);
			if (currentPage < 0) currentPage = instructions.length - 1;
			
			if (currentPage > instructions.length - 1) currentPage = 0;
			
			FP.world = instructions[currentPage];
			
		}
		
		public function menuButtonClick():void
		{
			trace("Tutorial class: Menu button has been clicked...");
			FP.world = new Menu("Mind the Gap");
			
		}
	}
}