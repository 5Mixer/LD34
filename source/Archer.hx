package ;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;

class Archer extends FlxSprite {
	var ground:FlxSprite;
	public var speed = 45;

	var arrows:FlxGroup;
	var hasShotThisShootCycle = false;
	var updateMode:Void -> Void;
	var startedShooting:Bool = false;
	var archerx = 0;

	public function new (X,Y,_ground,_arrows){
		super(X,Y);
		loadGraphic("assets/images/Soldier.png",32,32,true);

		animation.add("walkArcher",[31,32,33,34,35,36],11);
		animation.add("shoot",[11,12,13,14,15,16,17,18,19,20,21,22,23],9);

		archerx = Std.int(600 + (Math.random()*400));

		ground = _ground;
		arrows = _arrows;
	}
	override public function update (){
		super.update();

		velocity.y += 4;

		if (startedShooting == false){
			animation.play("walkArcher");
			velocity.x = -speed;
			startedShooting = x < archerx;
		}else{
			velocity.x = 0;
			animation.play("shoot");
			if (animation.frameIndex == 23 && hasShotThisShootCycle == false){
				//arrows.add(new Projectile(x+4,y+12,50,45));
				arrows.add(new Projectile(x+4,y+12,50,1+(Math.random()-0.6)));
				hasShotThisShootCycle = true;
			}
			if (animation.frameIndex ==	11){
				hasShotThisShootCycle = false;
			}
		}
	}

	override public function kill(){
		PlayState.money += 5;
		super.kill();
	}
}
