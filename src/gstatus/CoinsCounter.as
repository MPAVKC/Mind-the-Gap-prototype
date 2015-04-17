package gstatus 
{
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gtools.StatusComponent;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import flash.display.Bitmap;
	import gmenu.Mediator;
	
	
	
	import flash.events.Event;
	
	/**
	 * 
	 * @author 
	 */
	public class CoinsCounter extends StatusComponent
	{
		protected var buttonBmp:BitmapData;
		
		protected var label:TextField;
		protected var labelGlow:GlowFilter;
		protected var buttonGlow:GlowFilter;
		
		protected var color:uint;
		protected var glowColor:uint;
		
		protected var nColor:uint;
		protected var nGlow:uint;
		protected var hColor:uint;
		protected var hGlow:uint;
		
		protected var flickerTimer:Number = 0;
		
		protected var coin:Bitmap;
		private var m:Matrix = new Matrix;
		
		private var mediator:Mediator;
		
		public function CoinsCounter(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=50) 
		{	
			super(x, y, text, width, height);
			
			mediator = new Mediator();
			
			buttonBmp = new BitmapData(width + 50, height + 50, true, 0);
			
			nColor = 0xFFE620;
			nGlow = 0xFD3825;
			hColor = 0x6AFEFE;
			hGlow = 0x178FFF;
			
			color = nColor;
			glowColor = nGlow;
			
			createLabel();
			buttonGlow = new GlowFilter(glowColor, 1, 10, 10, 5, 3);
			drawCoin(Assets.COIN);
			drawLabel();
			
			graphic = new Stamp(buttonBmp, -25, -25);
			start();
		
		}
		
		protected function createLabel():void
		{
			label = new TextField();
			
			var tf:TextFormat = new TextFormat("Neon", 24, color);
			
			label.defaultTextFormat = tf;
			label.width = width;
			label.height = height;
			label.embedFonts = true;
			label.wordWrap = true;
			label.text = text + mediator.thecoinsnum;

			labelGlow = new GlowFilter(glowColor, 1, 10, 10, 2, 3);
			label.filters = [labelGlow];
			
		}
		
		protected function drawCoin(ImageData:Class):void
		{	
			g.clear();
			coin = new ImageData();
			
			m.tx = 9 + (height) * 0.5;
			m.ty = 9 + (height) * 0.5;
			
			buttonBmp.draw(coin, m);
			
		}
		
		override public function update():void 
		{
			super.update();
			redraw();
		}
		
		protected function drawLabel():void
		{
			m.tx = 25 + 10 + height;
			m.ty = 25 + (height - label.textHeight) * 0.5;
			buttonBmp.draw(label, m);
			
		}
		
		protected function redraw():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawCoin(Assets.COIN);
			
			label.textColor = color;
			labelGlow.color = glowColor;
			buttonGlow.color = glowColor;
			label.filters = [labelGlow];
			
			drawLabel();
			
		}
		
		public function start():void
		{
			FP.stage.addEventListener(Event.ENTER_FRAME, timerHandler);
			
		}
		
		public function timerHandler(event:Event):void 
		{
			createLabel();
			
		}
		
	}
}