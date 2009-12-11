package views 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	public class Gradient extends Sprite 
	{
		private var matrix : Matrix = new Matrix();
		private var gradient : Shape = new Shape();

		public function Gradient() 
		{
			matrix.createGradientBox(Vars.resX, Vars.resY, 0, 0, 0);
			gradient.graphics.beginGradientFill("radial", [0xFFFFFF, 0xCECECE], [100, 100], [0, 0xFF], matrix, "pad", "linearRGB", 0);
			gradient.graphics.moveTo(0, 0);
			gradient.graphics.lineTo(Vars.resX, 0);
			gradient.graphics.lineTo(Vars.resX, Vars.resY);
			gradient.graphics.lineTo(0, Vars.resY);
			gradient.graphics.lineTo(0, 0);
			gradient.graphics.endFill();
			
			this.addChild(gradient);		
		}	
	}
}

