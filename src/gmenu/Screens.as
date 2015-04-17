package gmenu 
{
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
	 * Used as a base for the menu, tutorial, and scores screens.
	 *  This is a modification of the 'BaseShowcase' class authored by Abel Toy (Rolpege) [http://abeltoy.com/]
	 * 
	 * @author Abel Toy
	 */
	public class Screens extends World 
	{
		protected var title:String;
		protected var xLoc:int;
		protected var yLoc:int;
		protected var fond:int;
		
		protected var label:Stamp;
		
		public function Screens(title:String, xLoc:int, yLoc:int, fond:int = 70) 
		{
			this.title = title;
			this.xLoc = xLoc;
			this.yLoc = yLoc;
			this.fond = fond;
			
		}
		
		override public function begin():void 
		{	
			super.begin();
			
			drawLabel(title);
			label.x += xLoc;
			label.y += yLoc;
			addGraphic(label);
			
		}
		
		protected function drawLabel(text:String):void
		{
			//render a textfield with a filter
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Comfortaa", fond, 0xFFFFFF, true);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = FP.width;
			t.height = 85;
			t.embedFonts = true;
			t.text = text;
			
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
		
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			
			super.update();
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
		
	}
}