package ;
import flixel.FlxSprite;

class Farmer extends FlxSprite {
	public function new (X,Y){
		super(X,Y);

		velocity.x = 70;

		loadGraphic("assets/images/Farmer.png",32,32,true);
	}

	override public function update (){
		super.update();

		velocity.y += 4;

	}
}
