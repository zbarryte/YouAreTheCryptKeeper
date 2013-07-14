package
{
	import org.flixel.*;
	
	public class Glob extends FlxG
	{
		public static const DEBUG_ON:Boolean = true;
		
		public static const CENT:FlxPoint = new FlxPoint(FlxG.width/2.0,FlxG.height/2.0);
		
		[Embed("assets/button.png")] public static var buttonSheet:Class;
		
		[Embed("assets/tileset_level.png")] public static var tilesetLevelSheet:Class;
		[Embed("assets/mapCSV_level_000.csv", mimeType = 'application/octet-stream')] public static const levelCSV:Class;
		
		// Macros
		public static function pressed(_keys:Array):Boolean {
			for (var i:int = 0; i < _keys.length; i++) {
				if (FlxG.keys.pressed(_keys[i])) {
					return true;
				}
			}
			return false;
		}
		public static function justPressed(_keys:Array):Boolean {
			for (var i:int = 0; i < _keys.length; i++) {
				if (FlxG.keys.justPressed(_keys[i])) {
					return true;
				}
			}
			return false;
		}
	}
}