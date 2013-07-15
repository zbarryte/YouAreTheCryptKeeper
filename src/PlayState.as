package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{	
		// spawns indices correspond to Glob.tilesetLevelSheet
		private const SPAWN_PLAYER:uint = 9;
		
		private var level:FlxTilemap;
		private var pauseGroup:PauseGroup;
		private var player:ZSprite;
				
		override public function create():void {
			
			// Level
			level = new FlxTilemap().loadMap(new Glob.levelCSV,Glob.tilesetLevelSheet,32,32);
			add(level);
			
			// Pause Group
			pauseGroup = new PauseGroup();
			add(pauseGroup);
			
			// Player
			player = groupFromSpawn(SPAWN_PLAYER,Mummy,level).members[0];
			add(player);
		}
		
		override public function update():void {
			// Is the game unpaused?
			if (!pauseGroup.isOn()) {
				super.update();
				
			}
			// Is the game paused?
			else {
				pauseGroup.update();
			}
		}
		
		private function groupFromSpawn(_spawn:uint,_class:Class,_map:FlxTilemap):FlxGroup {
			var _group:FlxGroup = new FlxGroup();
			var _array:Array = level.getTileInstances(_spawn);
			if (_array) {
				for (var i:uint = 0; i < _array.length; i++) {
					var _point:FlxPoint = pointForTile(_array[i],_map);
					_group.add(new _class(_point.x,_point.y));
				}
			}
			return _group;
		}
		
		private function pointForTile(_tile:uint,_map:FlxTilemap):FlxPoint {
			var _x:Number = 32*(int)(_tile%_map.widthInTiles);
			var _y:Number = 32*(int)(_tile/_map.widthInTiles);
			var _point:FlxPoint = new FlxPoint(_x,_y);
			return _point;
		}
	}
}