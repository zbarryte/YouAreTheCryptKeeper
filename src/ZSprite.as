package
{
	import flashx.textLayout.formats.BackgroundColor;
	
	import org.flixel.*;
	
	public class ZSprite extends FlxSprite
	{
		private const W:Number = 32;
		private const H:Number = 32;
		
		private const MOVE_VEL:Number = 222; // movement velocity in pixels per second
		private const MOVE_DECEL:Number = 2222; // deceleration in pixels per second^2
		
		// Controls
		private const GROUND_LEFT_KEY:Array = ["LEFT"]; // moves left on the ground
		private const GROUND_RIGHT_KEY:Array = ["RIGHT"]; // moves right on the ground
		private const GROUND_UP_KEY:Array = ["UP"]; // mounts stairs going up
		private const GROUND_DOWN_KEY:Array = ["DOWN"]; // mounts stairs going down
		private const STAIRS_FORWARD_UP_KEY:Array = ["UP","RIGHT"]; // climbs up forward stairs
		private const STAIRS_FORWARD_DOWN_KEY:Array = ["DOWN","LEFT"]; // climbs down forward stairs
		private const STAIRS_BACK_UP_KEY:Array = ["UP","LEFT"]; // climbs up back stairs
		private const STAIRS_BACK_DOWN_KEY:Array = ["DOWN","RIGHT"]; // climbs down back stairs
		
		private var surface:uint;
		// the surface that the sprite is occupying
		public static const GROUND:uint = 0;
		public static const STAIRS:uint = 1;
		
		private var direction:FlxPoint;
		// unit vector pointing in direction of motion
		private static const LEFT:FlxPoint = new FlxPoint(-1,0);
		private static const RIGHT:FlxPoint = new FlxPoint(1,0);
		private static const UP_RIGHT:FlxPoint = new FlxPoint(1/Math.pow(2,0.5),-1/Math.pow(2,0.5));
		private static const UP_LEFT:FlxPoint = new FlxPoint(-1/Math.pow(2,0.5),-1/Math.pow(2,0.5));
		private static const DOWN_LEFT:FlxPoint = new FlxPoint(-1/Math.pow(2,0.5),1/Math.pow(2,0.5));
		private static const DOWN_RIGHT:FlxPoint = new FlxPoint(1/Math.pow(2,0.5),1/Math.pow(2,0.5));
		
		private var firstStep:FlxSprite;
		
		public function ZSprite(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			if (_simpleGraphic) {
				loadGraphic(_simpleGraphic,true,true,W,H,true);
			} else {
				width = W;
				height = H;
			}
			
			surface = ZSprite.GROUND;
			drag = new FlxPoint(MOVE_DECEL,MOVE_DECEL);
		}
		
		override public function update():void {
			super.update();
			// Is the sprite on the ground?
			if (surface == ZSprite.GROUND && velocity.y == 0) {
				if (Glob.pressed(GROUND_LEFT_KEY)) {
					direction = ZSprite.LEFT;
					move();
				} else if (Glob.pressed(GROUND_RIGHT_KEY)) {
					direction = ZSprite.RIGHT;
					move();
				} else if (Glob.pressed(GROUND_UP_KEY)) {
					x = firstStep.x;
					y = firstStep.y;
					setSurface(ZSprite.STAIRS);
				} else if (Glob.pressed(GROUND_DOWN_KEY)) {
					x = firstStep.x;
					y = firstStep.y;
					setSurface(ZSprite.STAIRS);
				}
			}
			// Is the sprite on the stairs?
			else if (surface == ZSprite.STAIRS) {
				// forward stairs
				if (firstStep.facing == FlxObject.RIGHT) {
					if (Glob.pressed(STAIRS_FORWARD_UP_KEY)) {
						direction = ZSprite.UP_RIGHT;
						move();
					} else if (Glob.pressed(STAIRS_FORWARD_DOWN_KEY)) {
						direction = ZSprite.DOWN_LEFT;
						move();
					}
				}
				// back step
				else if (firstStep.facing == FlxObject.LEFT) {
					if (Glob.pressed(STAIRS_BACK_UP_KEY)) {
						direction = ZSprite.UP_LEFT;
						move();
					} else if (Glob.pressed(STAIRS_BACK_DOWN_KEY)) {
						direction = ZSprite.DOWN_RIGHT;
						move();
					}
				}
			}
		}
		
		private function move():void {
			velocity.x = MOVE_VEL*direction.x;
			velocity.y = MOVE_VEL*direction.y;
		}
		
		public function setSurface(_surface:uint):void {
			surface = _surface;
		}
		
		public function setFirstStep(_step:FlxSprite):void {
			firstStep = _step;
		}
		
		public function onGround():Boolean {
			return surface == ZSprite.GROUND;
		}
		
		public function onStairs():Boolean {
			return surface == ZSprite.STAIRS;
		}
	}
}