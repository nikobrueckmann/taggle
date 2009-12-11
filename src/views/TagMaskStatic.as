package views 
{
	import flash.display.Sprite;

	public class TagMaskStatic extends Sprite 
	{
		public var tagMaskStatic : Sprite = new Sprite();
		
		public function TagMaskStatic(textWidth:Number) : void
		{
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, textWidth + Vars.padding * 2, 25);
 		}	
	}
}
