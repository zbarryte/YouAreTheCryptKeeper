package
{
	import org.flixel.*;
	
	public class SplashState extends FlxState
	{
		private const SELECT_BUTTON_KEY:Array = ["SPACE","ENTER"];
		
		private var splashGroup:SplashGroup;
		
		override public function create():void {
			add(new FlxText(Glob.CENT.x,Glob.CENT.y,100,"Splash State"));
			
			splashGroup = new SplashGroup();
			add(splashGroup);
		}
	}
}