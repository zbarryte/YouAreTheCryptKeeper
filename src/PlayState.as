package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{	
		// spawns indices correspond to Glob.tilesetLevelSheet
		private const SPAWN_PLAYER:Array = [9];
		private const SPAWN_STAIRS_FORWARD:Array = [2,4];
		private const SPAWN_STAIRS_BACK:Array = [3,5];
		
		private var level:FlxTilemap;
		private var pauseGroup:PauseGroup;
		private var player:ZSprite;
		private var stairsForwardGroup:FlxGroup;
		private var stairsBackGroup:FlxGroup;
				
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
			
			// Stairs
			stairsForwardGroup = groupFromSpawn(SPAWN_STAIRS_FORWARD,FlxSprite,level);
			stairsBackGroup = groupFromSpawn(SPAWN_STAIRS_BACK,FlxSprite,level);
		}
		
		override public function update():void {
			// Is the game unpaused?
			if (!pauseGroup.isOn()) {
				super.update();
				
				var _overlapPoint:FlxSprite = stepOverlappedBySprite(player);
				if (player.onGround()) {
					if (_overlapPoint) {
						player.setFirstStep(_overlapPoint);
					} else {
						player.setFirstStep(null);
					}
				} else {
					if (!_overlapPoint) {
						player.setSurface(ZSprite.GROUND);
					}
				}
				
			}
			// Is the game paused?
			else {
				pauseGroup.update();
			}
		}
		
		private function stepOverlappedBySprite(_spr:FlxSprite):FlxSprite {
			for (var i:uint = 0; i < stairsForwardGroup.length; i++) {
				var _step:FlxSprite = stairsForwardGroup.members[i];
				if (_step.overlaps(_spr)) {
					_step.facing = FlxObject.RIGHT;
					return _step;
				}
			}
			for (i = 0; i < stairsBackGroup.length; i++) {
				_step = stairsBackGroup.members[i];
				if (_step.overlaps(_spr)) {
					_step.facing = FlxObject.LEFT;
					return _step;
				}
			}
			return null;
		}
		
		private function groupFromSpawn(_spawn:Array,_class:Class,_map:FlxTilemap):FlxGroup {
			var _group:FlxGroup = new FlxGroup();
			for (var i:uint = 0; i <_spawn.length; i++) {
				var _array:Array = level.getTileInstances(_spawn[i]);
				if (_array) {
					for (var j:uint = 0; j < _array.length; j++) {
						var _point:FlxPoint = pointForTile(_array[j],_map);
						_group.add(new _class(_point.x,_point.y));
					}
				}
			}
			return _group;
		}
		
		private function pointForTile(_tile:uint,_map:FlxTilemap):FlxPoint {
			var _x:Number = (_map.width/_map.widthInTiles)*(int)(_tile%_map.widthInTiles);
			var _y:Number = (_map.width/_map.widthInTiles)*(int)(_tile/_map.widthInTiles);
			var _point:FlxPoint = new FlxPoint(_x,_y);
			return _point;
		}
	}
}