package views 
{
	import models.Tag;

	import flash.display.Sprite;

	public class TagListCurrent  extends Sprite 
	{
		public var tagSpritesCurrent : Array;
		private	var  yPos : Number = 0;

		public var tagMaskCurrent : TagMaskCurrent;

		public function TagListCurrent() 
		{	
			tagMaskCurrent = new TagMaskCurrent();
			addChild(tagMaskCurrent);	
			this.mask = tagMaskCurrent;	
			tagSpritesCurrent = new Array();
			for(var i : uint = 0 ;i < Application.tagArray.length;i++) 
			{
				var tagSpriteCurrent : TagSpriteCurrent = new TagSpriteCurrent(new Tag(Application.tagArray[i], Application.relevanceArray[i]));
				tagSpritesCurrent.push(tagSpriteCurrent);				
				this.addChild(tagSpriteCurrent);
			}
			for (i = 0;i < tagSpritesCurrent.length; i++)
			{
				tagSpritesCurrent[i].y = yPos;
				yPos += tagSpritesCurrent[i].height + Vars.tagBoxSpacing;
			}
		}
	}
}
