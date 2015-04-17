package gButtons
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
	import gButtons.Button;
	import gmenu.Mediator;

	/**
	 * Check buttons for the settings of the game
	 *  This class is a modification of the 'NeonCheckbox' class 
	 *  authored by Abel Toy (Rolpege) [http://abeltoy.com/]. Some functions
	 *  were also used from the 'Checkbox' and 'NeonRadioButton' classes. 
	 *  Not all the code from the original class is used on this class. 
	 * 
	 *   -^ Note: The name of variables or functions may 
	 *      have been changed. 
	 * ...
	 * @author
	 */
	public class CheckButton extends Button
	{
		protected var buttonBmp:BitmapData;
		
		protected var label:TextField;
		protected var choice:TextField;
		protected var labelGlow:GlowFilter;
		protected var buttonGlow:GlowFilter;
		protected var checkGlow:GlowFilter;
		
		protected var color:uint;
		protected var glowColor:uint;
		
		protected var nColor:uint;
		protected var nGlow:uint;
		protected var hColor:uint;
		protected var hGlow:uint;
		
		protected var flickerTimer:Number = 0;
		
		protected var _checked:Boolean = false;
		private var achoice:String;
		
		private var mediator:Mediator;
		
		private var choiceChecked:Boolean;
		private var choiceAChecked:Boolean;
		private var choiceBChecked:Boolean;
		private var choiceCChecked:Boolean;
		
		public function CheckButton(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=50,
			  theChoice:String = "", callback:Function = null,checked:Boolean=false, params:Object=null) 
		{	
			super(x, y, text, width, height, callback, params);
			mediator = new Mediator();
			achoice = theChoice;
			
			this.checked = checked;
			
			buttonBmp = new BitmapData(width + 50, height + 50, true, 0);
			
			nColor = 0x6AFEFE;
			nGlow = 0x178FFF;
			hColor = 0xFFE620;
			hGlow = 0xFD3825;
			
			color = nColor;
			glowColor = nGlow;
			
			buttonGlow = new GlowFilter(glowColor, 1, 10, 10, 5, 3);
			checkGlow = new GlowFilter(glowColor, 1, 10, 10, 0, 3);
			
			checkSetting();
			createLabel();
			createChoice();
			
			drawButton();
			drawLabel();
			drawChoice();
			
			graphic = new Stamp(buttonBmp, -25, -25);
			
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
			label.text = text;
			
			labelGlow = new GlowFilter(glowColor, 1, 10, 10, 2, 3);
			label.filters = [labelGlow];
			
		}
		
		protected function createChoice():void
		{
			choice = new TextField();
			var tf:TextFormat;
			
			tf = new TextFormat("Neon", 24, 0x999999);
			choice.defaultTextFormat = tf;
			choice.width = width;
			choice.height = height;
			choice.embedFonts = true;
			choice.wordWrap = true;
			choice.text = achoice;
			if (checked) choice.filters = [checkGlow];
			else choice.filters = [];
		}
		public function createCheckedChoice():void
		{
			var tf:TextFormat;
			tf = new TextFormat("Neon", 24, color);
			choice.defaultTextFormat = tf;
			choice.width = width;
			choice.height = height;
			choice.embedFonts = true;
			choice.wordWrap = true;
			choice.text = achoice;
			if (checked) choice.filters = [checkGlow];
			else choice.filters = [];
		}
		
		public function drawChoice():void
		{
			/*choice = new TextField();
			var checkSize:Number = height * 0.5;
			var tf:TextFormat;
			
			if (checked)
			{
				tf = new TextFormat("Neon", 24, color);
			}
			else
			{
				tf = new TextFormat("Neon", 24, 0x999999);
			}
			choice.defaultTextFormat = tf;
			choice.width = width;
			choice.height = height;
			choice.embedFonts = true;
			choice.wordWrap = true;
			choice.text = achoice;
			if (checked) choice.filters = [checkGlow];
			else choice.filters = [];*/
			m.tx = 25 + 8;
			m.ty = 25 + 4;
			buttonBmp.draw(choice, m);
		}
		
		
		private var m:Matrix = new Matrix;
		protected function drawButton():void
		{
			g.clear();
			
			g.lineStyle(2, color, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER);
			g.drawCircle(height * 0.4, height * 0.4, height * 0.4);
			g.endFill();
			
			sprite.filters = [buttonGlow];
			
			m.tx = 25;
			m.ty = 25;
			buttonBmp.draw(sprite, m);
			
		}
		
		override public function update():void 
		{
			super.update();
			
			if (flickerTimer > 0)
			{
				buttonGlow.strength = Math.random() * 5;
				labelGlow.strength = Math.random() * 2;
				checkGlow.strength = Math.random() * 2;
				
				flickerTimer -= FP.elapsed;
				
				if (flickerTimer <= 0)
				{
					buttonGlow.strength = 5;
					labelGlow.strength = 2;
					checkGlow.strength = 2;
				}
				
				redraw();
				
			}
		}
		
		override protected function changeState(state:int = 0):void 
		{
			if (state == lastState) return;
			
			switch(state)
			{
				case NORMAL:
					color = nColor;
					glowColor = nGlow;
					flickerTimer = 0.25;
					break;
				case HOVER:
					color = hColor;
					glowColor = hGlow;
					flickerTimer = 0.25;
					break;
				case DOWN:
					flickerTimer = 0;
					color = 0x999999;
					buttonGlow.strength = 0;
					labelGlow.strength = 0;
					checkGlow.strength = 0;
					redraw();
					break;
			}
			
			super.changeState(state);
			
		}
		
		protected function drawLabel():void
		{
			m.tx = 25 + 10 + height;
			m.ty = 25 + 4;
			buttonBmp.draw(label, m);
			
		}
		
		protected function redraw():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton();
			
			label.textColor = color;
			labelGlow.color = glowColor;
			buttonGlow.color = glowColor;
			label.filters = [labelGlow];
			drawLabel();
			if (mediator.game_data.data.choi == true)
			{
				
				createCheckedChoice();
			}
			else {
				createChoice();
			}
			drawChoice();
			
		}
		
		public function set checked(value:Boolean):void 
		{
			if (_checked != value)
			{
				_checked = value;
			}
			
		}
		
		public function get checked():Boolean 
		{
			return _checked;
			
		}
		
		override protected function click():void 
		{
			if (checked) {
				checked = !checked;
				if (params != null) callback(checked, params);
				else callback();
			}else {
				checked = !checked;
				if (params != null) callback(checked, params);
				else callback();
			}
			checkSetting();
			mediator.game_data.data.choi = true;
			
		}
		
		private function checkSetting():void
		{
			
			
		}
	}
}