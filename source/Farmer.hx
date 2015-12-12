package ;
import flixel.FlxSprite;
import flixel.FlxG;

class Farmer extends FlxSprite {
	var left = ["LEFT","A"];
	var right = ["RIGHT", "D"];

	public function new (X,Y){
		super(X,Y);


		loadGraphic("assets/images/Farmer.png",32,32,true);
	}

	override public function update (){
		super.update();

		velocity.y += 4;

		if (FlxG.keys.anyPressed(right)){
			//RIGHT PRESSED.
			velocity.x = 70;
		}else if (FlxG.keys.anyPressed(left)){
			//LEFT PRESSED.
			velocity.x = -70;
		}else{
			velocity.x *= 0.5;
		}

	}
}
