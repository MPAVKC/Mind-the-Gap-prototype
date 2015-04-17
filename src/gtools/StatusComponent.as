package gtools 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class StatusComponent extends Component
	{		
		protected var text:String;
		
		public function StatusComponent(x:Number=0, y:Number=0, text:String = "", width:Number = 150, height:Number = 50) 
		{
			super(x, y);
			this.text = text;
			
			setHitbox(width, height);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}
}