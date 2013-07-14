package
{
	import org.flixel.*;
	
	public class Raider extends FlxSprite
	{
		private const W:Number = 32;
		private const H:Number = 32;
		
		public function Raider(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y);
			loadGraphic(Glob.raiderSheet,true,true,W,H,true);
		}
	}
}