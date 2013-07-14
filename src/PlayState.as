package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{	
		// spawn points correspond to indices in Glob.tilesetLevelSheet
		private const SPAWN_PLAYER:uint = 9;
		private const SPAWN_RAIDER:uint = 7;
		
		private var level:FlxTilemap;
		private var pauseGroup:PauseGroup;
		
		private var raiderGroup:FlxGroup;
		private var player:FlxSprite;
				
		override public function create():void {
			
			level = new FlxTilemap().loadMap(new Glob.levelCSV,Glob.tilesetLevelSheet,32,32);
			add(level);
			
			raiderGroup = new FlxGroup();
			var _raiderArray:Array = level.getTileInstances(SPAWN_RAIDER);
			if (_raiderArray) {
				for (var i:uint = 0; i < _raiderArray.length; i++) {
					
					var _point:FlxPoint = pointForTile(_raiderArray[i],level);
					var _raider:FlxSprite = new Raider(_point.x,_point.y);
					raiderGroup.add(_raider);
				}
			}
			add(raiderGroup);
			
			var _playerArray:Array = level.getTileInstances(SPAWN_PLAYER);
			if (_playerArray) {
				
				_point = pointForTile(_playerArray[0],level);
				player = new Mummy(_point.x,_point.y);
				add(player);
			}
			
			pauseGroup = new PauseGroup();
			add(pauseGroup);
		}
		
		override public function update():void {
			if (!pauseGroup.isOn()) {
				super.update();
				
			} else {
				pauseGroup.update();
			}
		}
		
		private function pointForTile(_tile:uint,_map:FlxTilemap):FlxPoint {
			var _x:Number = 32*(int)(_tile%_map.widthInTiles);
			var _y:Number = 32*(int)(_tile/_map.widthInTiles);
			var _p:FlxPoint = new FlxPoint(_x,_y);
			return _p;
		}
	}
}