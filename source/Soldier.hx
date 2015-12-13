package ;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;

class Soldier extends FlxSprite {
	var ground:FlxSprite;
	public var speed = 45;

	var arrows:FlxGroup;
	var hasShotThisShootCycle = false;

	public function new (X,Y,_ground,_arrows){
		super(X,Y);
		loadGraphic("assets/images/Soldier.png",32,32,true);

		animation.add("walk",[1,2,3,4,5,6],11);
		animation.add("shoot",[11,12,13,14,15,16,17,18,19,20,21,22,23],10);

		ground = _ground;
		arrows = _arrows;
	}
	override public function update (){
		super.update();

		velocity.y += 4;

		shootMode();

		velocity.x = -speed;

	}

	public function shootMode (){
		animation.play("shoot");

		if (animation.frameIndex == 23 && hasShotThisShootCycle == false){
			arrows.add(new Projectile(x+4,y+12,-45,50));
			hasShotThisShootCycle = true;
		}
		if (animation.frameIndex ==	11){
			hasShotThisShootCycle = false;
		}
	}
	public function walkMode (){
		animation.play("walk");
	}
}
