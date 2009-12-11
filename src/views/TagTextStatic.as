package views 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class TagTextStatic extends Sprite 
	{
		private var text : TextField;

		public function TagTextStatic(tagString : String) : void
		{	
			text = new TextField();
			text.embedFonts = true;
			text.text = tagString;
			text.selectable = false;
			text.autoSize = TextFieldAutoSize.RIGHT;	
			// warum so seltsames antiAlias?
			//text.antiAliasType = AntiAliasType.ADVANCED;
			text.setTextFormat(Vars.tagTextFormatStatic);
			text.autoSize = "left";
			this.addChild(text);
		}
	}
}

