package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import gmenu.Mediator;
	
	/**
	 * ...
	 * @author AKM
	 */
	public class Diamond extends Entity
	{
		private var mediator:Mediator;
		public function Diamond(locX:int, locY:int)
		{
			mediator = new Mediator();
			graphic = new Image(Assets.DIAMOND);
			
			setHitbox(100, 100);
			
			type="diamond"; 
			x = locX + 10;
			y = locY + 10;
		}
		
		public function destroy():void
		{
			mediator.level2Complete = true
			mediator.reachDestination = true;
			mediator.theHP = 100;
			FP.world.remove(this);
		}

	}
	
}