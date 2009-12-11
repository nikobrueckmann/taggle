package views 
{
	import flash.display.Sprite;

	public class TagBoxStatic extends Sprite 
	{
		public var tagBoxStatic : Sprite = new Sprite();
		
		public function TagBoxStatic(textWidth:Number) : void
		{
			graphics.beginFill(Vars.boxColor);
			graphics.drawRect(0, 0, textWidth + Vars.padding * 2, 25);

			filters = [Vars.ds];	
 		}	
	}
}
