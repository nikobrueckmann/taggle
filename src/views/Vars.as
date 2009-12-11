package views 
{
	import flash.filters.DropShadowFilter;
	import flash.text.TextFormat;
	import flash.system.Capabilities;

	public class Vars 
	{
		public static const resX : uint = Capabilities.screenResolutionX;
		public static const resY : uint = Capabilities.screenResolutionY;

		public static const tagBoxSpacing : uint = 5;
		public static const padding : uint = 4;

		public static const rand : uint = 75;
		public static const firstY : uint = rand + (25 + tagBoxSpacing) * 5;

		public static const boxColor : uint = 0x000000;
		public static const highlight : uint = 0xFF009B;
		public static const textColor : uint = 0xFFFFFF;
		
		public static const ds : DropShadowFilter = new DropShadowFilter(5, 135, 0x000000, 0.5, 5, 5, 0.8, 2, false, false, false);

		public static const dragSwitch : Number = 0.015;

		public static const tagTextFormat : TextFormat = new TextFormat(new ITCAvantGardeGothicStd().fontName, 60, 0xffffff);
		public static const tagTextFormatStatic : TextFormat = new TextFormat(new ITCAvantGardeGothicStd().fontName, 60, 0xffffff);
	}
}
