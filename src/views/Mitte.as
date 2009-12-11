package views 
{
	import flash.display.Sprite;

	public class Mitte extends Sprite 
	{
		private var mitte : Sprite = new Sprite;

		public function Mitte() 
		{
			mitte.graphics.lineStyle(0.25, 0x000000, 1);
			mitte.graphics.moveTo(Vars.resX / 2, 0);
			mitte.graphics.lineTo(Vars.resX / 2, Vars.resY);
			
			this.addChild(mitte);
		}	
	}
}
