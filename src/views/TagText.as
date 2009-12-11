package views 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class TagText extends Sprite 
	{
		private var text : TextField;

		public function TagText(tagString : String) : void
		{	
			text = new TextField();
			text.embedFonts = true;
			text.text = tagString;
			text.selectable = false;
			text.autoSize = TextFieldAutoSize.RIGHT;	
			// warum so seltsames antiAlias?
			//text.antiAliasType = AntiAliasType.ADVANCED;
			text.setTextFormat(Vars.tagTextFormat);
			text.autoSize = "left";
			this.addChild(text);
		}
	}
}
