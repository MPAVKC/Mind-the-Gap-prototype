package game
{
	import Assets;
	import gmenu.Scores;
	import gtools.Background;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import flash.ui.MouseCursor;
	import gButtons.EndButton;
	import net.flashpunk.FP;
	import gmenu.Menu;
	import gmenu.Mediator;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import net.flashpunk.graphics.Stamp;
	import flash.geom.Matrix;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.MouseCursor;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import gButtons.NavigationButton;
	import flash.text.Font;
	
	
	/**
	 * ...
	 * @author AKM
	 */
	public class  CongratulatoryMessage extends World
	{
		private var nextLevel:EndButton;
		private var quit_to_menu:EndButton;
		private var m:Matrix = new Matrix
		
		protected var title:String;
		protected var xLoc:int;
		protected var yLoc:int;
		
		protected var label:Stamp;
		protected var boxLabel:Stamp;
		private var toscores:EndButton;
		
		private var mediator:Mediator;
		public function CongratulatoryMessage(source:*) {
			super();
			mediator = new Mediator;
			add(new gtools.Background(source));
			if (!mediator.gotoscores)
			{
	
				
				drawBox("Level " + mediator.theLevel + " Time: " + mediator.game_data.data.tempTime + "\n" 
					+ "You score for this level: " +  formulascore() + "\n");
					nextLevel = new EndButton(200, 500, "Continue to " + "\n" + " Level " + (mediator.theLevel + 1), 150, 55, continueClick)
				add(nextLevel);
			}
			else
			{
				toscores = new EndButton(200, 500, "Continue to " + "\n" + "Scores", 150, 55, continuetoScores);
				drawBox("Level " + mediator.theLevel+ " Time: " + mediator.game_data.data.tempTime + "\n" 
					+ "Your score for this level: " +  formulascore() + "\n"
					+ "Your overall score: " );
				
				add(toscores);
			}
			quit_to_menu = new EndButton(450, 500, "Quit to Menu", 150, 55, menuButtonClick);
			add(quit_to_menu);
		}
		
		override public function begin():void 
		{	
			super.begin();
			
			drawLabel("Congratulations!" + "\n" + "You made it to " + mediator.game_data.data.destination + " without dying!");
			
			label.x += 0;
			label.y += 40;
			boxLabel.x += 0;
			boxLabel.y += 250;
			addGraphic(label);
			addGraphic(boxLabel);
			
		}
		
		//the update method each world should have so the mouse cursor adapts correctly
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			
			super.update();
		}
		
		protected function drawLabel(text:String):void
		{
			//render a textfield with a filter
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Comfortaa", 30, 0xFFFFFF, true);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = FP.width;
			t.height = 600;
			t.embedFonts = true;
			t.text = text ;
			
			t.filters = [new GlowFilter(brightness(FP.screen.color, -0.5), 0.6, 2, 2, 6, 2)];
			
			var bd:BitmapData = new BitmapData(800, t.textHeight + 10, true, 0);
			var m:Matrix = new Matrix();
			
			m.tx = 5;
			m.ty = 5;
			bd.draw(t, m);
			
			label = new Stamp(bd);
			label.x = -5;
			label.y = -5;
			
		}
		
		protected function drawBox(text:String):void
		{
			//render a textfield with a filter
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Comfortaa", 30, 0xFFFFFF, true);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = FP.width;
			t.height = 600;
			t.embedFonts = true;
			t.text = text ;
			
			t.filters = [new GlowFilter(brightness(FP.screen.color, -0.5), 0.6, 2, 2, 6, 2)];
			
			var bd:BitmapData = new BitmapData(800, t.textHeight + 10, true, 0);
			var m:Matrix = new Matrix();
			
			m.tx = 5;
			m.ty = 5;
			bd.draw(t, m);
			
			boxLabel = new Stamp(bd);
			boxLabel.x = -5;
			boxLabel.y = -5;
			
		}
		
		//this method changes the brightness of an hex color by ratio.
		//positive number makes it lighter, negative makes it darker.
		protected function brightness(color:uint, ratio:Number):uint
		{
			var r:int = color >> 16 & 0xFF;
			var g:int = color >> 8 & 0xFF;
			var b:int = color & 0xFF;
			
			r = brightnessBit(r, ratio);
			g = brightnessBit(g, ratio);
			b = brightnessBit(b, ratio);
			
			return FP.getColorRGB(r, g, b);
			
		}
		
		//helper of brightness()
		private function brightnessBit(bit:int, ratio:Number):int
		{
			return Math.round(Math.min(Math.max(0, bit + (bit * ratio)), 255));
			
		}
		
		public function menuButtonClick():void
		{
			trace("CongratulatoryMessage class: Menu button has been clicked...");
			//mediator.game_data.clear();
			FP.world = new Menu("Mind the Gap");
			
		}
		
		public function continueClick():void
		{
			trace("CongratulatoryMessage class: Continue button has been clicked...");
			
			if (mediator.theLevel == 2) {
				trace("CongratolatoryMessage class: The game will now continue to level two...");
				FP.world = new LevelTwo();
				mediator.game_data.data.destination = "Logan Airport";
			}
			if(mediator.theLevel == 3){
				if (mediator.theLevel == 3)
				{
					trace("CongratolatoryMessage class: The game will now continue to level three...");
					FP.world = new LevelThree();
					mediator.game_data.data.destination = "London, England";
					
				}
			}
			
			
		}
		
		public function continuetoScores():void {
			trace("CongratulatoryMessage class: Continue to Scores button has been clicked...");
			FP.world = new Scores();
			mediator.game_data.clear();
		}
		
		public function formulascore():int
		{
			var sco:int = ((((mediator.game_data.data.giventime * 60) - mediator.game_data.data.timetaken) * 1000) / 6);
			trace(sco);
			return sco;
		}
	}
	
}