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
	public class Ticket extends Entity
	{
		private var mediator:Mediator;
		public function Ticket(locX:int, locY:int)
		{
			mediator = new Mediator();
			graphic = new Image(Assets.TICKET);
			
			setHitbox(100, 50);
			
			type="ticket"; 
			x = locX + 10;
			y = locY + 10;
		}
		
		public function destroy():void
		{
			trace("Ticket class: Level one has been completed...");
			mediator.level1Complete = true
			mediator.reachDestination = true;
			mediator.theHP = 100;
			FP.world.remove(this);
		}

	}
	
}