package ;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;

class Car extends FlxSprite implements Speed{
	var ground:FlxSprite;
	public var speed = 230;

	public function new (X,Y,_ground){
		super(X,Y);
		loadGraphic("assets/images/Car.png",60,40,true);

		animation.add("drive",[0,1,2,3],7);

		immovable = true;

		ground = _ground;
	}
	override public function update (){
		super.update();

		animation.play("drive");
		velocity.x = speed;

		if (x > 1500) kill();

	}
}
