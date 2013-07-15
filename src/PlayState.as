package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{	
		// spawn points correspond to indices in Glob.tilesetLevelSheet
		private const SPAWN_PLAYER:uint = 9;
		private const SPAWN_RAIDER:uint = 7;
		
		private const TILE_STAIRS_FORWARD:Array = [2,4];
		private const TILE_STAIRS_BACK:Array = [3,5];
		
		private const TILE_COLLIDE:Array = [1];
		
		private var stairsForwardArray:Array;
		private var stairsBackArray:Array;
		
		private var level:FlxTilemap;
		private var pauseGroup:PauseGroup;
		
		private var raiderGroup:FlxGroup;
		private var player:Mummy;
				
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
			
			stairsForwardArray = new Array();
			for (i = 0; i < TILE_STAIRS_FORWARD.length; i++) {
				var _stairsForwardArray:Array = level.getTileInstances(TILE_STAIRS_FORWARD[i]);
				if (_stairsForwardArray) {
					for (var j:uint = 0; j < _stairsForwardArray.length; j++) {
						_point = pointForTile(_stairsForwardArray[j],level);
						stairsForwardArray.push(_point);
					}
				}
			}
			stairsBackArray = new Array();
			for (i = 0; i < TILE_STAIRS_BACK.length; i++) {
				var _stairsBackArray:Array = level.getTileInstances(TILE_STAIRS_BACK[i]);
				if (_stairsBackArray) {
					for (j = 0; j < _stairsBackArray.length; j++) {
						_point = pointForTile(_stairsBackArray[j],level);
						stairsForwardArray.push(_point);
					}
				}
			}
			
			for (i = 0; i < TILE_COLLIDE.length; i++) {
				level.setTileProperties(i,FlxObject.ANY,FlxObject.separate);
			}
			
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
				
				var _p:FlxPoint = stairsOverlappedBySpriteAt(player);
				if (_p != null) {
					player.stairPoint = _p;
					player.over = true;
				} else {
					player.over = false;
					player.onGround = true;
				}
				
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
		
		private function stairsOverlappedBySpriteAt(_spr:FlxSprite):FlxPoint {
			for (var i:uint = 0; i < stairsForwardArray.length; i++) {
				var _point:FlxPoint = stairsForwardArray[i];
				if ((_point.x <= _spr.x && _spr.x <= _point.x + 32 &&
					_point.y <= _spr.y && _spr.y <= _point.y + 32) ||
					(_point.x <= _spr.x + 32 && _spr.x + 32 <= _point.x + 32 &&
						_point.y <= _spr.y + 32 && _spr.y + 32 <= _point.y + 32)) {
					return _point;
				}
			}
			
			for (i = 0; i < stairsBackArray.length; i++) {
				_point = stairsBackArray[i];
				if ((_point.x <= _spr.x && _spr.x <= _point.x + 32 &&
					_point.y <= _spr.y && _spr.y <= _point.y + 32) ||
					(_point.x <= _spr.x + 32 && _spr.x + 32 <= _point.x + 32 &&
						_point.y <= _spr.y + 32 && _spr.y + 32 <= _point.y + 32)) {
					return _point;
				}
			}
			return null;
		}
	}
}