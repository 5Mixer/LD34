package ;
import flixel.FlxSprite;

class Soldier extends FlxSprite {
	var ground:FlxSprite;
	public var speed = 70;
	
	public function new (X,Y,_ground){
		super(X,Y);
		loadGraphic("assets/images/Soldier.png",32,32,true);


		ground = _ground;
	}
	override public function update (){
		super.update();

		velocity.y += 4;

		velocity.x = -speed;

	}
}
