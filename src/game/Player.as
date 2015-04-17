package game
{
	/**
	 * ...
	 * @author Monirath Phay
	 */
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import gmenu.Mediator;
	
	public class Player extends Entity
	{
		
		public var spr:Spritemap = new Spritemap(Assets.WILLIAM, 51, 71);
		private var mediator:Mediator;
		
		public function Player() {
			mediator = new Mediator();
			spr.add("right", [0, 1, 2], 2, true);
			spr.add("walkright", [4, 5, 6, 7], 4, true);
			spr.add("left", [8, 9, 10], 2, true);
			spr.add("walkleft", [12, 13, 14, 15], 4, true);
			spr.add("jump", [3], 4);
			graphic = spr;
			
			setHitbox(77, 96);
		}
		override public function update():void
		{
			if (Input.check(Key.RIGHT) && x < 749) {x += 2;}
			if (Input.pressed(Key.RIGHT)) {spr.play("walkright");}
			if (Input.released(Key.RIGHT)) {spr.play("right");}
			if (Input.check(Key.LEFT) && x > 0) {x -= 2;}
			if (Input.pressed(Key.LEFT)) {spr.play("walkleft");}
			if (Input.released(Key.LEFT)) {spr.play("left");}
			if (Input.check(Key.UP) && y > 0) { y -= 2; }
			if (Input.check(Key.DOWN) && y < 520) { y += 2; }
			
			var coin:GameCoin = collide("coin", x, y) as GameCoin;
			var endjourney:Treasure = collide("treasure", x, y) as Treasure;
			var ticket:Ticket = collide("ticket", x, y) as Ticket;
			var diamond:Diamond = collide("diamond", x, y) as Diamond;
			
			
			if (coin)
			{
				mediator.thecoinsnum = 1;
				coin.destroy();
			}
			if (endjourney)
			{
				mediator.reachDestination = true;
				endjourney.destroy();
			}
			
			if (ticket)
			{
				ticket.destroy();
			}
			
			if (diamond)
			{
				diamond.destroy();
			}
		}
		
	}

}