package gstatus 
{
	import flash.text.TextField;
	import net.flashpunk.FP;
	import gtools.StatusComponent;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	import net.flashpunk.graphics.Stamp;
	import flash.events.Event;
	import flash.utils.getTimer;
	import gmenu.Mediator;
	
	/**
	 * Timer
	 * 
	 * @author ...
	 */
	public class Clock extends StatusComponent
	{
		protected var buttonBmp:BitmapData;
		
		protected var label:TextField;
		private var timeLabel:TextField;
		private var minLabel:TextField;
		private var colonLabel:TextField;
		private var secLabel:TextField;
		
		protected var labelGlow:GlowFilter;
		private var timeLabelGlow:GlowFilter;
		private var minLabelGlow:GlowFilter;
		private var colonLabelGlow:GlowFilter;
		private var secLabelGlow:GlowFilter;
		
		protected var buttonGlow:GlowFilter;
		protected var color:uint;
		protected var glowColor:uint;
		protected var nColor:uint;
		protected var nGlow:uint;
		protected var hColor:uint;
		protected var hGlow:uint;
		private var m:Matrix = new Matrix;
		
		private var gameStartTime:Number;
		private var gameTime:Number;
		
		protected var flickerTimer:Number = 0;
		
		private var playTime:Number = 0;
		private var mediator:Mediator;
		
		private var min:String;
		private var sec:String;
		
		
		public function Clock(x:Number = 0, y:Number = 0, text:String = "", width:Number = 150, height:Number = 50, time:Number = 1)
		{
			super(x, y, text, width, height);
			mediator = new Mediator();
			mediator.game_data.data.giventime = time;
			min = "" + time;
			sec = "0";
			trace(min);
			playTime = (time * 60) * 1000;
			
			buttonBmp = new BitmapData(width + 50, height + 50, true, 0);
			
			//the color for each state, stored
			nColor = 0xFEFEE4;
			nGlow = 0xF7675E;
			hColor = 0x6AFEFE;
			hGlow = 0x178FFF;
			
			color = nColor;
			glowColor = nGlow;
			
			//createLabel();
			createTimeLabel();
			createMinLabel();
			createColonLabel();
			createSecLabel();
			
			
			buttonGlow = new GlowFilter(glowColor, 1, 10, 10, 5, 3);
			
			//drawLabel();
			drawTimeLabel();
			drawMinLabel();
			drawColonLabel();
			drawSecLabel();
			
			
			graphic = new Stamp(buttonBmp, -25, -25);
			
			gameStartTime = getTimer() + playTime;
			gameTime = 0;
			
		}
		
		protected function createLabel():void
		{
			//create the label, method is run just once.
			label = new TextField();
			
			var tf:TextFormat = new TextFormat("Neon", 24, color);
			//tf.align = "center";
			
			label.defaultTextFormat = tf;
			label.width = width;
			label.height = height;
			label.embedFonts = true;
			label.wordWrap = true;
			label.text = text;
			
			labelGlow = new GlowFilter(glowColor, 1, 10, 10, 2, 3);
			label.filters = [labelGlow];
			
		}
		private function createTimeLabel():void
		{
			//create the label, method is run just once.
			timeLabel = new TextField();
			
			
			var tf:TextFormat = new TextFormat("Neon", 24, color);
			//tf.align = "center";
			
			timeLabel.defaultTextFormat = tf;
			timeLabel.width = width;
			timeLabel.height = height;
			timeLabel.embedFonts = true;
			timeLabel.wordWrap = true;
			timeLabel.text = "Time: ";
			
			timeLabelGlow = new GlowFilter(glowColor, 1, 10, 10, 2, 3);
			timeLabel.filters = [timeLabelGlow];
			
		}
		private function createMinLabel():void
		{
			//create the label, method is run just once.
			minLabel = new TextField();
			
			var tf:TextFormat = new TextFormat("Neon", 24, color);
			//tf.align = "center";
			
			minLabel.defaultTextFormat = tf;
			minLabel.width = width;
			minLabel.height = height;
			minLabel.embedFonts = true;
			minLabel.wordWrap = true;
			minLabel.text = min;
			
			
			minLabelGlow = new GlowFilter(glowColor, 1, 10, 10, 2, 3);
			minLabel.filters = [minLabelGlow];
		}
		
		private function createColonLabel():void
		{
			//create the label, method is run just once.
			colonLabel = new TextField();
			
			var tf:TextFormat = new TextFormat("Neon", 24, color);
			//tf.align = "center";
			
			colonLabel.defaultTextFormat = tf;
			colonLabel.width = width;
			colonLabel.height = height;
			colonLabel.embedFonts = true;
			colonLabel.wordWrap = true;
			colonLabel.text = ":";
			
			
			colonLabelGlow = new GlowFilter(glowColor, 1, 10, 10, 2, 3);
			colonLabel.filters = [colonLabelGlow];
		}
		
		private function createSecLabel():void
		{
			//create the label, method is run just once.
			secLabel = new TextField();
			
			var tf:TextFormat = new TextFormat("Neon", 24, color);
			//tf.align = "center";
			
			secLabel.defaultTextFormat = tf;
			secLabel.width = width;
			secLabel.height = height;
			secLabel.embedFonts = true;
			secLabel.wordWrap = true;
			secLabel.text = sec;
			
			
			secLabelGlow = new GlowFilter(glowColor, 1, 10, 10, 2, 3);
			secLabel.filters = [secLabelGlow];
		}
		
		override public function update():void 
		{
			super.update();
			
			//this helps us make the flicker screen. we can set flickerTimer somewhere in the code to some value, this will be the duration
			//of the flicker in seconds. during flicker, the strength of the glow filters is random.
			if (flickerTimer > 0)
			{
				buttonGlow.strength = Math.random() * 5;
				labelGlow.strength = Math.random() * 2;
				
				flickerTimer -= FP.elapsed;
				
				if (flickerTimer <= 0)
				{
					buttonGlow.strength = 5;
					labelGlow.strength = 2;
				}
				
				redraw();
			}
			
		}
		
		
		protected function drawLabel():void
		{
			m.tx = 25;
			m.ty = 25 + (height - label.textHeight) * 0.5;
			buttonBmp.draw(label, m);
			
		}
		
		protected function drawTimeLabel():void
		{
			m.tx = 25;
			m.ty = 25 + (height - timeLabel.textHeight) * 0.5;
			
			buttonBmp.draw(timeLabel, m);
			
			
		}
		protected function drawMinLabel():void
		{
			m.tx = 100;
			m.ty = 25 + (height - timeLabel.textHeight) * 0.5;
			buttonBmp.draw(minLabel, m);
			
		}
		
		protected function drawColonLabel():void
		{
			m.tx = 150;
			m.ty = 25 + (height - timeLabel.textHeight) * 0.5;
			buttonBmp.draw(colonLabel, m);
			
		}
		
		protected function drawSecLabel():void
		{
			m.tx = 165;
			m.ty = 25 + (height - timeLabel.textHeight) * 0.5;
			buttonBmp.draw(secLabel, m);
			
		}
		
		protected function redraw():void
		{
			createTimeLabel();
			createMinLabel();
			createColonLabel();
			createSecLabel();
			
			//we don't use multiple stamps, but just redraw everything on the button bitmapdata. as we have to redraw the same things every frame, because
			//of the iflter, this is a bit easier and less consuming.
			buttonBmp.fillRect(buttonBmp.rect, 0);
			
			timeLabel.textColor = color;
			minLabel.textColor = color;
			colonLabel.textColor = color;
			secLabel.textColor = color;
			
			timeLabelGlow.color = glowColor;
			minLabelGlow.color = glowColor;
			colonLabelGlow.color = glowColor;
			secLabelGlow.color = glowColor;
			
			buttonGlow.color = glowColor;
			
			timeLabel.filters = [timeLabelGlow];
			minLabel.filters = [timeLabelGlow];
			colonLabel.filters = [colonLabelGlow]
			secLabel.filters = [timeLabelGlow];
			
			drawTimeLabel();
			drawMinLabel();
			drawColonLabel();
			drawSecLabel();
			
		}
		
		public function start():void
		{
			FP.stage.addEventListener(Event.ENTER_FRAME, timerHandler);
			//trace("Timer has started");
			
		}
		
		public function timerHandler(event:Event):void 
		{
			gameTime = getTimer();
			
			var temp:Number = gameStartTime - gameTime; 
			var elapsedTime:Number = gameTime - (gameStartTime - playTime);
			convertMinSec(temp);
			upTime(elapsedTime);
			
			if (temp <= 1000)
			{
				stop();
				mediator.timerunout = true;
			}
			
			redraw();
		}
		
		public function convertMinSec(time:Number) :void 
		{
			var seconds:Number = Math.floor(time/1000);
			var minutes:Number = Math.floor(seconds/60);
			seconds -= minutes * 60;
			
			if ((minutes < 10) && (seconds >= 10))
			{
				text = "Time: " + "0" + minutes + " min " + seconds + " sec";
				min = "0" + minutes;
				sec = "" + seconds;
				
			}
			else if ((minutes < 10) && (seconds < 10))
			{
				text = "Time: " + "0" + minutes + " min " + "0" + seconds + " sec";
				min = "0" + minutes;
				sec = "0" + seconds;
			}
			
		}
		
		public function upTime(time:Number) :void 
		{
			var seconds:Number = Math.floor(time/1000);
			var minutes:Number = Math.floor(seconds/60);
			seconds -= minutes * 60;
			
			mediator.game_data.data.timetaken = (minutes * 60) + seconds
			
			if ((minutes < 10) && (seconds >= 10))
			{
				mediator.game_data.data.tempTime = "0" + minutes + " min " + seconds + " sec" ;
				
			}
			else if ((minutes < 10) && (seconds < 10))
			{
				mediator.game_data.data.tempTime = "0" + minutes + " min " + "0" + seconds + " sec";
	
			}
			
		}
		
		public function stop():void 
		{
			FP.stage.removeEventListener(Event.ENTER_FRAME, timerHandler);
			
		}
		
	}
}