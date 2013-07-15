package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{	
		// spawns indices correspond to Glob.tilesetLevelSheet
		private const SPAWN_PLAYER:Array = [9];
		private const SPAWN_STAIRS_FORWARD:Array = [2,4];
		private const SPAWN_STAIRS_BACK:Array = [3,5];
		private const SPAWN_COLLIDE:Array = [1,2,3];
		
		private var level:FlxTilemap;
		private var pauseGroup:PauseGroup;
		private var player:ZSprite;
		private var stairsForwardGroup:FlxGroup;
		private var stairsBackGroup:FlxGroup;
		private var stairsGroup:FlxGroup;
		private var collideGroup:FlxGroup;
				
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
			stairsGroup = new FlxGroup();
			stairsForwardGroup = groupFromSpawn(SPAWN_STAIRS_FORWARD,FlxSprite,level);
			for (var i:uint = 0; i < stairsForwardGroup.length; i++) {
				stairsForwardGroup.members[i].facing = FlxObject.RIGHT;
				stairsGroup.add(stairsForwardGroup.members[i]);
			}
			stairsBackGroup = groupFromSpawn(SPAWN_STAIRS_BACK,FlxSprite,level);
			for (i = 0; i < stairsBackGroup.length; i++) {
				stairsBackGroup.members[i].facing = FlxObject.LEFT;
				stairsGroup.add(stairsBackGroup.members[i]);
			}
			
			// Collision Tiles
			collideGroup = groupFromSpawn(SPAWN_COLLIDE,ZSprite,level);
			for (i = 0; collideGroup.length; i++) {
				collideGroup.members[i].immovable = true;
			}
		}
		
		override public function update():void {
			// Is the game unpaused?
			if (!pauseGroup.isOn()) {
				super.update();
				
				if (player.velocity.y > 0) {
					FlxG.collide(collideGroup,player);
				}
				
				var _overlapPoint:FlxSprite = stepClosestToSprite(player);
				if (_overlapPoint) {
					player.setFirstStep(_overlapPoint);
				} else {
					player.setSurface(ZSprite.GROUND);
					player.setFirstStep(player);
				}
				
				if (player.onGround()) {
					player.acceleration.y = Glob.GRAV_ACCEL;
				} else if (player.onStairs()) {
					player.acceleration.y = 0;
				}
				
				/*
				if (player.onGround()) {
					if (player.velocity.y >= 0) {
						FlxG.collide(collideGroup,player);
						player.acceleration.y = Glob.GRAV_ACCEL;
					}
					if (_overlapPoint) {
						player.setFirstStep(_overlapPoint);
					} else {
						player.setFirstStep(null);
					}
				} else {
					player.acceleration.y = 0;
					if (!_overlapPoint) {
						player.setSurface(ZSprite.GROUND);
					}
				}
				*/
				
			}
			// Is the game paused?
			else {
				pauseGroup.update();
			}
		}
		
		private function stepClosestToSprite(_spr:FlxSprite):FlxSprite {
			const _MIN_DIST_SQ:Number = _spr.width*_spr.height;
			
			var _closest:FlxSprite = null;
			var _closestDistSq:Number = Number.MAX_VALUE;
			
			var _sprCent:FlxPoint = new FlxPoint(_spr.x+_spr.width/2.0,_spr.y+_spr.height/2.0);
			
			for (var i:uint = 0; i < stairsGroup.length; i++) {
				var _step:FlxSprite = stairsGroup.members[i];
				var _stepCent:FlxPoint = new FlxPoint(_step.x+_step.width/2.0,_step.y+_step.height/2.0);
				var _distSq:Number = Math.pow(_sprCent.x-_stepCent.x,2) + Math.pow(_sprCent.y-_stepCent.y,2);
				
				if (_distSq < _closestDistSq && _distSq < _MIN_DIST_SQ) {
					_closest = _step;
					_distSq = _closestDistSq;
				}
			}
			return _closest;
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