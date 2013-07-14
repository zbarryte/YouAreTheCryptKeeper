package
{
	import org.flixel.*;
	
	public class GameOverState extends FlxState
	{
		override public function create():void {
			add(new FlxText(Glob.CENT.x,Glob.CENT.y,100,"Game Over State"));
		}
	}
}