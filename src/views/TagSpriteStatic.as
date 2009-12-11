package views 
{
	import caurina.transitions.Tweener;

	import models.TagStatic;	

	import flash.display.Sprite;

	public class TagSpriteStatic extends Sprite 
	{
		public var tagSpriteStatic : TagSpriteStatic;
		public var tagBoxStatic : TagBoxStatic;
		public var tagTextStatic : TagTextStatic;
		public var tagMaskStatic : TagMaskStatic;
		public var tagStatic : TagStatic;

		private var oldHeight : Number;
		private var heightChange : Number;

		
		public function TagSpriteStatic(tagStatic : TagStatic) 
		{
			
			this.tagStatic = tagStatic;
			tagTextStatic = new TagTextStatic(tagStatic.nameStatic);
			oldHeight = tagTextStatic.height;			
			tagTextStatic.height = 25 - Vars.padding * 2;
			heightChange = tagTextStatic.height / oldHeight;
			tagTextStatic.width = tagTextStatic.width * heightChange;
			tagTextStatic.x = Vars.padding;
			tagTextStatic.y = Vars.padding;

			tagBoxStatic = new TagBoxStatic(tagTextStatic.width);
			tagMaskStatic = new TagMaskStatic(tagTextStatic.width);
						
			addChild(tagBoxStatic);
			addChild(tagTextStatic);
			//addChild(tagMaskStatic);	
			
			//warum funktioneirt maske nicht auf schatten?			
			//tagBoxStatic.mask = tagMaskStatic;	
		} 

		public function moveTo(toX : Number, toY : Number , time : Number) : void 
		{
			Tweener.addTween(this.tagBoxStatic, {x: toX, y:toY, time: time, transition: "easeInOutExpo"});
			Tweener.addTween(this.tagTextStatic, {x: toX + Vars.padding, y:toY + Vars.padding, time: time, transition: "easeInOutExpo"});			
		}
	}
}