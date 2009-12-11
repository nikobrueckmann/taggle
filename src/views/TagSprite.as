package views 
{
	import caurina.transitions.Tweener;

	import models.Tag;

	import flash.display.Sprite;

	public class TagSprite extends Sprite 
	{

		public var tag : Tag;

		public var whiteBox : WhiteBox;
		public var scaleBox : ScaleBox;
		public var tagBox : TagBox;
		public var tagText : TagText;	

		public function TagSprite(tag : Tag) 
		{	
			this.tag = tag;
			tagText = new TagText(tag.name);
			var oldHeight : Number = tagText.height;			
			tagText.height = tag.relevance * 100 - Vars.padding * 2;
			var heightChange : Number = tagText.height / oldHeight;
			tagText.width = tagText.width * heightChange;
			tagText.x = Vars.padding;
			tagText.y = Vars.padding;

			whiteBox = new WhiteBox(tag.relevance, tagText.width);
			scaleBox = new ScaleBox(tag.relevance, tagText.width);
			tagBox = new TagBox(tag.relevance, tagText.width);
			
			scaleBox.visible = false;
			whiteBox.visible = false;
			
			// warum geht das nicht?
			//this.width = tagBox.width;
			//this.height = tagBox.height;

			addChild(whiteBox);
			addChild(tagBox);
			addChild(scaleBox);
			addChild(tagText);	
		}	

		public function moveTo(toX : Number, toY : Number , time : Number) : void 
		{
			Tweener.addTween(this.whiteBox, {x: toX, y:toY, time: time, transition: "easeInOutExpo"});
			Tweener.addTween(this.scaleBox, {x: toX, y:toY, time: time, transition: "easeInOutExpo"});
			Tweener.addTween(this.tagBox, {x: toX, y:toY, time: time, transition: "easeInOutExpo"});
			Tweener.addTween(this.tagText, {x: toX + Vars.padding, y:toY + Vars.padding, time: time, transition: "easeInOutExpo"});		
		}
	}
}
