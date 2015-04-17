package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author AKM
	 */
	public class GameCoin extends Entity
	{
		public function GameCoin(locX:int, locY:int)
		{
			graphic = new Image(Assets.GAMECOIN);
			
			setHitbox(40, 40);
			
			type="coin"; 
			x = locX + 10;
			y = locY + 10;
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}

	}
	
}