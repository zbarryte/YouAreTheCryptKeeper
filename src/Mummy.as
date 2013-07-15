package
{
	import org.flixel.*;
	
	public class Mummy extends FlxSprite
	{	
		private const W:Number = 32;
		private const H:Number = 32;
		
		private const GROUND_000_KEY:Array = ["RIGHT"];
		private const GROUND_045_KEY:Array = ["UP"];
		private const GROUND_135_KEY:Array = ["UP"];
		private const GROUND_180_KEY:Array = ["LEFT"];
		private const GROUND_225_KEY:Array = ["DOWN"];
		private const GROUND_315_KEY:Array = ["DOWN"];
		private const STAIRS_045_KEY:Array = ["UP","RIGHT"];
		private const STAIRS_135_KEY:Array = ["UP","LEFT"];
		private const STAIRS_225_KEY:Array = ["DOWN","LEFT"];
		private const STAIRS_315_KEY:Array = ["DOWN","RIGHT"];
		
		// unit vectors pointing in direction of motion
		private const THETA_000:FlxPoint = new FlxPoint(1,0);
		private const THETA_045:FlxPoint = new FlxPoint(1/Math.pow(2,0.5),-1/Math.pow(2,0.5));
		//private const THETA_090:FlxPoint = new FlxPoint(0,-1);
		private const THETA_135:FlxPoint = new FlxPoint(-1/Math.pow(2,0.5),-1/Math.pow(2,0.5));
		private const THETA_180:FlxPoint = new FlxPoint(-1,0);
		private const THETA_225:FlxPoint = new FlxPoint(-1/Math.pow(2,0.5),1/Math.pow(2,0.5));
		//private const THETA_270:FlxPoint = new FlxPoint(0,1);
		private const THETA_315:FlxPoint = new FlxPoint(1/Math.pow(2,0.5),1/Math.pow(2,0.5));
		
		private const MOVE_VEL:Number = 222;
		
		private var onGround:Boolean;
		private var over:Boolean;
		private var overDir:uint;
		
		public function Mummy(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y);
			loadGraphic(Glob.mummySheet,true,true,W,H,true);
			
			onGround = true;
			over = false;
			overDir = FlxObject.NONE;
			facing = FlxObject.LEFT;
		}
		
		override public function update():void {
			
			super.update();
			
			// for now
			if (FlxG.keys.justPressed("SHIFT")) {
				onGround = !onGround;
			}
			if (FlxG.keys.pressed("SPACE")) {
				over = !over;
			}
			if (FlxG.keys.pressed("M")) {
				overDir = FlxObject.LEFT;
			} else if (FlxG.keys.pressed("N")) {
				overDir = FlxObject.RIGHT;
			} else {overDir = FlxObject.NONE;}
			//
			
			
			if (onGround) {
				if (Glob.pressed(GROUND_000_KEY)) {
					move(THETA_000);
				}
				else if (Glob.pressed(GROUND_045_KEY) && over && overDir == FlxObject.RIGHT) {
					move(THETA_045);
				}
				else if (Glob.pressed(GROUND_135_KEY) && over && overDir == FlxObject.LEFT) {
					move(THETA_135);
				}
				else if (Glob.pressed(GROUND_180_KEY)) {
					move(THETA_180);
				}
				else if (Glob.pressed(GROUND_225_KEY) && over && overDir == FlxObject.RIGHT) {
					move(THETA_225);
				}
				else if (Glob.pressed(GROUND_315_KEY) && over && overDir == FlxObject.LEFT) {
					move(THETA_315);
				}
				else {
					velocity.x = 0;
					velocity.y = 0;
				}
			}
			// otherwise on stairs
			else {
				if (Glob.pressed(STAIRS_045_KEY) && overDir == FlxObject.RIGHT) {
					move(THETA_045);
				}
				else if (Glob.pressed(STAIRS_135_KEY) && overDir == FlxObject.LEFT) {
					move(THETA_135);
				}
				else if (Glob.pressed(STAIRS_225_KEY) && overDir == FlxObject.RIGHT) {
					move(THETA_225);
				}
				else if (Glob.pressed(STAIRS_315_KEY) && overDir == FlxObject.LEFT) {
					move(THETA_315);
				} else {
					velocity.x = 0;
					velocity.y = 0;
				}
			}
		}
		
		private function move(_dr:FlxPoint):void {
			velocity.x = _dr.x*MOVE_VEL;
			velocity.y = _dr.y*MOVE_VEL;
		}
	}
}