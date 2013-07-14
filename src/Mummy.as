package
{
	import org.flixel.*;
	
	public class Mummy extends FlxSprite
	{	
		private const W:Number = 32;
		private const H:Number = 32;
		
		private const LEFT_KEY:Array = ["LEFT"];
		private const RIGHT_KEY:Array = ["RIGHT"];
		private const UP_KEY:Array = ["UP"];
		private const DOWN_KEY:Array = ["DOWN"];
		
		// unit vectors pointing in direction of motion
		private const THETA_000:FlxPoint = new FlxPoint(1,0);
		private const THETA_045:FlxPoint = new FlxPoint(1/Math.pow(2,0.5),-1/Math.pow(2,0.5));
		private const THETA_090:FlxPoint = new FlxPoint(0,-1);
		private const THETA_135:FlxPoint = new FlxPoint(-1/Math.pow(2,0.5),-1/Math.pow(2,0.5));
		private const THETA_180:FlxPoint = new FlxPoint(-1,0);
		private const THETA_225:FlxPoint = new FlxPoint(-1/Math.pow(2,0.5),1/Math.pow(2,0.5));
		private const THETA_270:FlxPoint = new FlxPoint(0,1);
		private const THETA_315:FlxPoint = new FlxPoint(1/Math.pow(2,0.5),1/Math.pow(2,0.5));
		
		private const MOVE_VEL:Number = 222;
		
		private var onStairs:Boolean;
		
		public function Mummy(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y);
			loadGraphic(Glob.mummySheet,true,true,W,H,true);
			
			onStairs = false;
			facing = FlxObject.LEFT;
		}
		
		override public function update():void {
			super.update();
		}
		
		private function move(_dr:FlxPoint):void {
			velocity.x = _dr.x*MOVE_VEL;
			velocity.y = _dr.y*MOVE_VEL;
		}
	}
}