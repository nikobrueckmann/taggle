package views 
{
	import flash.display.Sprite;

	public class ScaleBox extends Sprite 
	{
		public function ScaleBox(relevance : Number, breite : Number) : void
		{
			//graphics.beginFill(vars.highlight);
			graphics.beginFill(0xFFCCFF);
			graphics.drawRect(0, 0, (breite + Vars.padding * 2) * relevance, relevance * 100);
		}	
	}
}

