package views 
{
	import models.TagStatic;

	import flash.display.Sprite;	

	import views.TagSpriteStatic;

	public class TagListStatic extends Sprite 
	{
		public var tagSpritesStatic : Array;
		private	var  yPos : Number = 0;

		public function TagListStatic() 
		{
			tagSpritesStatic = new Array();
			for(var i : uint = 0 ;i < Application.tagArrayStatic.length;i++) 
			{
				var tagSpriteStatic : TagSpriteStatic = new TagSpriteStatic(new TagStatic(Application.tagArrayStatic[i]));
				tagSpritesStatic.push(tagSpriteStatic);				
				this.addChild(tagSpriteStatic);		
			}
			
			for (i = 0;i < tagSpritesStatic.length; i++)
			{
				tagSpritesStatic[i].y = yPos;
				yPos += tagSpritesStatic[i].height + Vars.tagBoxSpacing;
			}	
		}

		public function atIndexStatic(i : uint) : TagSpriteStatic 
		{
			return tagSpritesStatic[i];
		}

		public function lengthStatic() : uint 
		{
			return tagSpritesStatic.length;
		}
	}
}