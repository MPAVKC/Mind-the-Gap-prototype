package game
{	
	import adobe.utils.CustomActions;
	import Assets;
	import gtools.Background;
	import gButtons.CheckButton;
	import net.flashpunk.FP;
	
	
	/**
	 * Game level 1.
	 * 
	 * @author A
	 */
	public class LevelOne extends GameLevels 
	{	private var Q:CheckButton;
		private var choiceAQ:CheckButton;
		private var choiceBQ:CheckButton;
		private var choiceCQ:CheckButton;
		public function LevelOne()
		{
			super();
			this.theTime = 5;
		}
		
		override public function begin():void 
		{
			
			add(new Background(Assets.PROV));
			super.begin();
			this.timer.start();
			trace("LevelOne class: Timer from level one has started...");
			
			add(new Ticket(550, 100));
			
			question();
		}
		
		public function question():void
		{
			Q = new CheckButton(150, 150, "Oh no a mugger!", 250, 50, "Q", obstacle);
			add(Q);
			
			choiceAQ = new CheckButton(150, 225, "Beg for life", 250, 50, "A", choiceA);
			add(choiceAQ);
			
			choiceBQ = new CheckButton(150, 275, "Falconpunch", 250, 50, "B", choiceB);
			add(choiceBQ);
			
			choiceCQ = new CheckButton(150, 325, "Sell mixtape", 250, 50, "C", choiceC);
			add(choiceCQ);
			
		}
		
		public function obstacle():void {
			trace("Obstacle has been printed.");
		}
		
		public function choiceA():void
		{
			trace("Choice A has been clicked");
			mediator.theHP = -100;
			FP.world.remove(choiceAQ);
			FP.world.remove(choiceBQ);
			FP.world.remove(choiceCQ);
			FP.world.remove(Q);
		}
		
		public function choiceB():void
		{
			trace("Choice B has been clicked");
			mediator.theHP = -50;
			FP.world.remove(choiceAQ);
			FP.world.remove(choiceBQ);
			FP.world.remove(choiceCQ);
			FP.world.remove(Q);
			
		}
		
		public function choiceC():void
		{
			trace("Choice C has been clicked");
			FP.world.remove(choiceAQ);
			FP.world.remove(choiceBQ);
			FP.world.remove(choiceCQ);
			FP.world.remove(Q);
			
		}
	}
}