package
{
	import org.flixel.*;
	
	public class ScoreState extends FlxState
	{	
		override public function create():void {
			add(new FlxText(Glob.CENT.x,Glob.CENT.y,100,"Score State"));
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new SplashState());
			}
		}
	}
}