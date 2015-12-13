package ;
import flixel.FlxSprite;

class Projectile extends FlxSprite {
	var killTimer:Float = 0;
	public function new (X,Y,angle,charge){
		super(X,Y);

		velocity.x = charge * (Math.sin(angle+90) * 180 / Math.PI);
		velocity.y = charge * (Math.cos(angle+90) * 180 / Math.PI);

		makeGraphic(9,2,flixel.util.FlxColor.BLACK);

	}

	override public function update (){
		super.update();

		killTimer += flixel.FlxG.elapsed;
		if (killTimer > 4) kill();


		velocity.y += 4;

		angle = (Math.atan2(velocity.x,velocity.y) * 180 / Math.PI)-90;
	}
}
