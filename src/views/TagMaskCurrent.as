package views 
{
	import flash.display.Sprite;

	public class TagMaskCurrent extends Sprite 
	{
		public var tagMaskCurrent : Sprite = new Sprite();
		
		public function TagMaskCurrent() : void
		{
			graphics.beginFill(0x000000);
			// hier w�re die h�he der tagListCurrent wohl besser als y-wert
			graphics.drawRect(- Vars.resX/2, 0, Vars.resX/2, Vars.resY);
 		}	
	}
}
