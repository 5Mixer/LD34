package ;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;

class Soldier extends FlxSprite implements Speed{
	var ground:FlxSprite;
	public var speed = 45;

	public function new (X,Y,_ground){
		super(X,Y);
		loadGraphic("assets/images/Soldier.png",32,32,true);

		animation.add("walkSoldier",[1,2,3,4,5,6],13);


		ground = _ground;
	}
	override public function update (){
		super.update();

		velocity.y += 4;

		animation.play("walkSoldier");
		velocity.x = -speed;

	}
	override public function kill(){
		PlayState.money += 5;
		super.kill();
	}
}
