package views 
{
	import flash.events.Event;
	import flash.display.Sprite;

	public class RateView extends Sprite
	{
		private var gradient : Gradient = new Gradient();
		private var mitte : Mitte = new Mitte();

		private var tagList : TagList = new TagList();
		private var tagListCurrent : TagListCurrent = new TagListCurrent();

		private var tagListStatic : TagListStatic = new TagListStatic();

		public function RateView() 
		{			
			tagListStatic.x = Vars.resX / 2;
			tagListStatic.y = Vars.rand;

			tagList.x = Vars.resX / 2;
			tagList.y = Vars.firstY;
			
			tagListCurrent.x = Vars.resX / 2;
			tagListCurrent.y = Vars.firstY;

			tagList.addEventListener(Event.ENTER_FRAME, tagList.mouseInOut);
			tagList.addEventListener(Event.ENTER_FRAME, tagList.dragTracingH);
			tagList.addEventListener(Event.ENTER_FRAME, tagList.dragTracingV);
			
			this.addChild(gradient);		
			this.addChild(mitte);	
			this.addChild(tagList);
			this.addChild(tagListCurrent);
			this.addChild(mitte);
			this.addChild(tagListStatic);
		
			for(var i : uint = 0 ;i < tagListStatic.tagSpritesStatic.length;i++) 
			{	
				tagListStatic.tagSpritesStatic[i].moveTo(-tagListStatic.tagSpritesStatic[i].tagBoxStatic.width / 2, 0, 1);
			}
			for(i = 0 ;i < tagListCurrent.tagSpritesCurrent.length;i++) 
			{	
				tagListCurrent.tagSpritesCurrent[i].moveTo(-tagListCurrent.tagSpritesCurrent[i].tagBox.width + 1, 0, 1);
			}
		}
	}
}
