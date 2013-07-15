package
{
	import org.flixel.*;
	
	public class ZSprite extends FlxSprite
	{
		private const W:Number = 32;
		private const H:Number = 32;
		
		private const MOVE_VEL:Number = 444; // movement velocity in pixels per second
		
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
		private static const GROUND:uint = 0;
		private static const STAIRS:uint = 1;
		
		private var direction:FlxPoint;
		// unit vector pointing in direction of motion
		private static const LEFT:FlxPoint = new FlxPoint(-1,0);
		private static const RIGHT:FlxPoint = new FlxPoint(1,0);
		private static const UP_RIGHT:FlxPoint = new FlxPoint(1/Math.pow(2,0.5),-1/Math.pow(2,0.5));
		private static const UP_LEFT:FlxPoint = new FlxPoint(-1/Math.pow(2,0.5),-1/Math.pow(2,0.5));
		private static const DOWN_LEFT:FlxPoint = new FlxPoint(-1/Math.pow(2,0.5),1/Math.pow(2,0.5));
		private static const DOWN_RIGHT:FlxPoint = new FlxPoint(1/Math.pow(2,0.5),1/Math.pow(2,0.5));
		
		public function ZSprite(_x:Number=0,_y:Number=0,_simpleGraphic:Class=null)
		{
			super(_x,_y);
			loadGraphic(_simpleGraphic,true,true,W,H,true);
			
			surface = ZSprite.GROUND;
		}
		
		override public function update():void {
			super.update();
			FlxG.log("hello world");
			// Is the sprite on the ground?
			if (surface == ZSprite.GROUND) {
				
			}
			// Is the sprite on the stairs?
			else if (surface == ZSprite.STAIRS) {
				
			}
		}
		
		private function move():void {
			velocity.x = MOVE_VEL*direction.x;
			velocity.y = MOVE_VEL*direction.y;
		}
	}
}