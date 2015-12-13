package ;
import flixel.FlxSprite;
import flixel.FlxG;

class Farmer extends FlxSprite {
	var left = ["LEFT","A"];
	var right = ["RIGHT", "D"];
	public var healthBar:HealthBar;
	public var lives = 10;

	public function new (X,Y){
		super(X,Y);

		healthBar = new HealthBar(x,y);

		loadGraphic("assets/images/Farmer.png",32,32,true);
		animation.add("idle",[0]);
		animation.add("walk",[1,2,3,4,5,6],10);
	}

	override public function update (){
		super.update();

		healthBar.move(x+4,y);

		velocity.y += 4;

		if (FlxG.keys.anyPressed(right)){
			//RIGHT PRESSED.
			velocity.x = 70;
			flipX = false;
			animation.play("walk");
		}else if (FlxG.keys.anyPressed(left)){
			//LEFT PRESSED.
			flipX = true;
			velocity.x = -70;
			animation.play("walk");
		}else{
			velocity.x *= 0.5;
			animation.play("idle");

		}

	}
	public function decreaseLives (){
		lives--;
		healthBar.setValue(lives/10);
		if (lives == 0) kill();
	}
}
