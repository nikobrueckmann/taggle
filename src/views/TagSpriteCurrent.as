package views 
{
	import caurina.transitions.Tweener;

	import models.Tag;

	import flash.display.Sprite;

	public class TagSpriteCurrent extends Sprite 
	{
		public var tag : Tag;
		public var tagBox : TagBox;
		public var tagText : TagText;	
		
		private var oldHeight : Number;
		private var heightChange : Number;
		

		public function TagSpriteCurrent(tag : Tag) 
		{	
			this.tag = tag;
			tagText = new TagText(tag.name);
			oldHeight = tagText.height;			
			tagText.height = tag.relevance * 100 - Vars.padding * 2;
			heightChange = tagText.height / oldHeight;
			tagText.width = tagText.width * heightChange;
			tagText.x = Vars.padding;
			tagText.y = Vars.padding;

			tagBox = new TagBox(tag.relevance, tagText.width);

			addChild(tagBox);
			addChild(tagText);	
		}	

		public function moveTo(toX : Number, toY : Number , time : Number) : void 
		{
			Tweener.addTween(this.tagBox, {x: toX, y:toY, time: time, transition: "easeInOutExpo"});
			Tweener.addTween(this.tagText, {x: toX + Vars.padding, y:toY + Vars.padding, time: time, transition: "easeInOutExpo"});			
		}
	}
}
