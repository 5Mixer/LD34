package ;
import flixel.FlxSprite;

class Projectile extends FlxSprite {
	var killTimer:Float = 0;
	public function new (X,Y,_angle,charge:Float){
		super(X,Y);

		//velocity.x = -charge * (Math.cos(angle) * (180 / Math.PI));
		//velocity.y = -charge * (Math.sin(angle) * (180 / Math.PI));
		//velocity.x = (Math.cos(_angle) * (180 / Math.PI)) * 20;
		//velocity.y = (Math.sin(_angle) * (180 / Math.PI)) * 20;
		velocity.x = Math.cos((_angle-180)* Math.PI / 180) * (400*charge);
		velocity.y = Math.sin((_angle-180)* Math.PI / 180) * (400*charge);

		makeGraphic(8,1,flixel.util.FlxColor.BLACK);
		drag.set();
	}

	override public function update (){
		super.update();

		killTimer += flixel.FlxG.elapsed;
		if (killTimer > 4) kill();


		velocity.y += 4;

		angle = -((Math.atan2(velocity.x,velocity.y) * (180 / Math.PI)))-90;
	}
}
