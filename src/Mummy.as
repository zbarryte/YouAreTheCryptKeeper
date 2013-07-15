package
{
	import org.flixel.*;
	
	public class Mummy extends ZSprite
	{	
		public function Mummy(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y,Glob.mummySheet);
		}
	}
}