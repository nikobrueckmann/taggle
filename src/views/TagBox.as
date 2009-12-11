package views 
{
	import flash.display.Sprite;

	public class TagBox extends Sprite 
	{
		public var tagBox : Sprite = new Sprite();
		
		public function TagBox(relevance:Number, textWidth:Number) : void
		{
			graphics.beginFill(Vars.boxColor);
			graphics.drawRect(0, 0, textWidth + Vars.padding * 2, relevance * 100);
			alpha = relevance;
			filters = [Vars.ds];					
 		}	
	}
}
