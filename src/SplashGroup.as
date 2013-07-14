package
{
	import org.flixel.*;
	
	public class SplashGroup extends ZGroup
	{
		public function SplashGroup(MaxSize:uint=0)
		{
			super(MaxSize);
			
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y-ZButton.H-ZGroup.SPACING,Glob.buttonSheet,playReaction,"play",ZButton.CURSED));
			add(new ZButton(Glob.CENT.x-ZButton.W/2.0,Glob.CENT.y,Glob.buttonSheet,scoreReaction,"score"));
		}
		
		// Button Reactions
		private function playReaction():void {
			FlxG.switchState(new PlayState());
		}
		private function scoreReaction():void {
			FlxG.switchState(new ScoreState());
		}
	}
}