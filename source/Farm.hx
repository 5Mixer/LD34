package ;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

class Farm extends FlxSprite {
	var farmers:FlxTypedGroup<Farmer>;

	public function new (X,Y,farmerGroup:FlxTypedGroup<Farmer>){
		super(X,Y);
		loadGraphic("assets/images/Farm.png",192,160,true);

		farmers = farmerGroup;
	}

	override public function update () {
		if (flixel.FlxG.keys.justPressed.SPACE){
			farmers.add(new Farmer(x,y));
		}
	}
}
