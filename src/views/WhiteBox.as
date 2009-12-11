package views 
{
	import flash.display.Sprite;

	public class WhiteBox extends Sprite 
	{	
		public function WhiteBox(relevance : Number, textWidth : Number) : void
		{
			graphics.beginFill(0xffffff);
			graphics.drawRect(0, 0, textWidth + Vars.padding * 2, relevance * 100);
		}
	}
}
