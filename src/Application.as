package 
{
	import library.Asset;

	import views.RateView;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;

	import caurina.transitions.properties.ColorShortcuts;
	ColorShortcuts.init();

	[SWF( backgroundColor = "0xFFFFFF" , frameRate = "30" , width = "1280" , height = "800" )]

	public class Application extends Sprite 
	{
		// singleton???
		public static var tagArrayStatic : Array = new Array("flat beat", "mr. oizo", "f communications", "1999", "electronic");
		public static var tagArray : Array = new Array("artsy", "indie", "french", "experimental", "glitchy", "techno");
		public static var relevanceArray : Array = new Array("1", "0.85", "0.7", "0.55", "0.4", "0.25");

		private var rateView : RateView = new RateView();

		public function Application() : void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			this.addChild(rateView);	
			this.addChild(Asset.create("ImageOne"));
		}
	}
}