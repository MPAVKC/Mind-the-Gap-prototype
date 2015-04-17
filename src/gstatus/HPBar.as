package gstatus
{
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import gtools.StatusComponent;
	import flash.events.Event;
	
	import gmenu.Mediator;
	
	/**
	 * ...
	 * @author Abel Toy (Rolpege) [http://abeltoy.com/]
	 */
	public class HPBar extends StatusComponent
	{
		protected var barBmp:BitmapData;
		
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
		
		private var mediator:Mediator;
		
		private var hpValue:int;
		private var labelformat:TextFormat;
		
		public function HPBar(x:Number = 0, y:Number = 0, value:int = 100, width:Number = 150, height:Number = 50) 
		{
			
			super(x, y, "" + value + " % HP", width, height);
			hpValue = value;
			
			mediator = new Mediator();
			mediator.theHP = hpValue;
			
			barBmp = new BitmapData(width + 50, height + 50, true, 0);
			
			//the color for each state, stored
			nColor = 0x6AFEFE;
			nGlow = 0x178FFF;
			hColor = 0x6AFEFE;
			hGlow = 0x6AFEFE;
			
			color = nColor;
			glowColor = nGlow;
			
			//we create the label in a different method, as we won't recreate it.
			createLabel();
			buttonGlow = new GlowFilter(glowColor, 1, 10, 10);
			drawBar();
			drawLabel();
			
			graphic = new Stamp(barBmp, -25, -25);
			start();
		}
		
		protected function createLabel():void
		{
			mediator.theHP;
			//create the label, method is run just once.
			label = new TextField();
			
			labelformat = new TextFormat("Neon", 24, 0x000000);
			labelformat.align = "center";
			
			label.defaultTextFormat = labelformat;
			label.width = width;
			label.height = height;
			label.embedFonts = true;
			label.wordWrap = true;
			label.text = "" + mediator.theHP + " % HP";
			
			labelGlow = new GlowFilter(0xFFFFFF, 1, 10, 10, 2, 3);
			label.filters = [labelGlow];
		}
		
		private var m:Matrix = new Matrix;
		
		//draw a health points bar with some glow filter
		protected function drawBar():void
		{
			g.clear();
			g.beginFill(0xC0C0C0);
			g.drawRect(0, 0, width, height);
			g.endFill()
			
			var someValue:int = Math.abs(mediator.theHP);
			
			if ((someValue == 100) || (someValue >= 51))
			{
				g.beginFill(0x66CCFF);
				g.drawRect(0, 0, someValue * 2, height);
				g.endFill();
			}
			else if ((someValue == 50) || (someValue >= 26))
			{
				g.beginFill(0xFF8C00);
				g.drawRect(0, 0, someValue * 2, height);
				g.endFill();
			}
			else
			{
				g.beginFill(0xFF0000);
				g.drawRect(0, 0, someValue * 2, height);
				g.endFill();
			}
			
			g.lineStyle(2, color, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER);
			g.drawRect(0, 0, width, height);
			
			sprite.filters = [buttonGlow];
			
			
			m.tx = 25;
			m.ty = 25;
			barBmp.draw(sprite, m);
			
		}
		
		override public function update():void 
		{
			super.update();
			
			redraw();
		}
		
		protected function drawLabel():void
		{
			m.tx = 25;
			m.ty = 25 + (height - label.textHeight) * 0.5;
			barBmp.draw(label, m);
		}
		
		protected function redraw():void
		{
			
			//we don't use multiple stamps, but just redraw everything on the button bitmapdata. as we have to redraw the same things every frame, because
			//of the iflter, this is a bit easier and less consuming.
			barBmp.fillRect(barBmp.rect, 0);
			drawBar();
			
			label.textColor = color;
			labelGlow.color = glowColor;
			buttonGlow.color = glowColor;
			label.filters = [labelGlow];
			labelformat = new TextFormat("Neon", 24, 0x000000);
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