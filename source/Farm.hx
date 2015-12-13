package ;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

class Farm extends FlxSprite {
	var farmers:FlxTypedGroup<Farmer>;

	public var healthBar:HealthBar;
	public var lives = 30;

	public function new (X,Y,farmerGroup:FlxTypedGroup<Farmer>){
		super(X,Y);
		loadGraphic("assets/images/Farm.png",192,160,true);

		healthBar = new HealthBar(x,y);
		immovable = true;

		farmers = farmerGroup;
	}

	override public function update () {
		super.update();

		healthBar.move(getMidpoint().x+4,getMidpoint().y-10);

		if (flixel.FlxG.keys.justPressed.SPACE){
			farmers.add(new Farmer(x,y));
		}
	}
	public function decreaseLives (){
		lives--;
		healthBar.setValue(lives/30);
		if (lives == 0) kill();
	}
}
