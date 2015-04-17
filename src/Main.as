package 
{
	import com.greensock.plugins.HexColorsPlugin;
	import com.greensock.plugins.TweenPlugin;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import gmenu.Menu;
	import gmenu.Mediator;
	
	/**
	 * This is the class that will be in charge of initiating the game
	 * ...
	 * @author AKM
	 * ...
	 * 
	 * Note: The game was created using code written by the team developers and also
	 * using code writen by others developers that are not part of the team. The code 
	 * taken from external sources can be either just a method or a whole class.
	 * The code that is not authored by the team will be noted by giving credit to the 
	 * original author. This code will be identified by the following comment on the first
	 * line of the method: (author <name of author>)
	 * If the original code was modified, it will also be stated on the 
	 * comments section of that particular method or class.
	 * 
	 * Also the User Interface of this game was based from the tutorial FlashPunk UI Components:
	 * Adavnced Graphics, Extra Skins, and Polish by Abel Toy. 
	 * (code.tutsplus.com/tutorials/flashpunk-ui-components-advanced-graphics-extra-skins-and-polish--active-11544)
	 * 
	 */
	public class Main extends Engine
	{
		[Embed(source = "../assets/fonts/Comfortaa-Bold.ttf", fontFamily = "Comfortaa", embedAsCFF = "false")] private var COMFORTAA:Class;
		[Embed(source = "../assets/fonts/NEUROPOL.TTF", fontFamily = "Neon", embedAsCFF = "false")] private var NEON:Class;
		[Embed(source = "../assets/fonts/Bitter-Bold.ttf", fontFamily = "Bitter", embedAsCFF = "false")] private var BITTER:Class;
		
		private var mediator:Mediator;
		
		public function Main():void 
		{
			super(800, 600);
		}
		
		override public function init():void 
		{
			super.init();
			mediator = new Mediator();
			mediator.game_data.clear();
			
			
			TweenPlugin.activate([HexColorsPlugin]);
			
			// initiates the game
			FP.world = new Menu("Mind the Gap");
			trace("Main class: a menu has been created...");
			
		}
	}
}