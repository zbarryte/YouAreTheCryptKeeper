package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		
		private var level:FlxTilemap;
		private var pauseGroup:PauseGroup;
				
		override public function create():void {
			
			level = new FlxTilemap().loadMap(new Glob.levelCSV,Glob.tilesetLevelSheet,32,32);
			add(level);
			
			pauseGroup = new PauseGroup();
			add(pauseGroup);
		}
		
		override public function update():void {
			
			super.update();
			
			/*
			if (pauseGroup.isOn()) {
				updatePauseGroup();
			} else {
				if (Glob.justPressed(PAUSE_KEY)) {
					pauseGroup.toggle();
				}
			}
			*/
		}
		
		/*
		private function updatePauseGroup():void {
			if (Glob.justPressed(CURSE_FORWARD_KEY)) {
				pauseGroup.curseFoward();
			} else if (Glob.justPressed(CURSE_BACK_KEY)) {
				pauseGroup.curseBack();
			} else if (Glob.justPressed(SELECT_BUTTON_KEY)) {
				pauseGroup.select();
			} else if (Glob.justPressed(PAUSE_KEY)) {
				pauseGroup.reset();
			}
		}
		*/
	}
}