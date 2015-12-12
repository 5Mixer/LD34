package ;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

class Castle extends FlxSprite {
	var spawnTimer:Float = 0;
	var soldiers:FlxTypedGroup<Soldier>;
	var ground:FlxSprite;

	public function new (X,Y,soldierGroup:FlxTypedGroup<Soldier>,_ground:FlxSprite){
		super(X,Y);
		loadGraphic("assets/images/Castle.png",192,160,true);

		soldiers = soldierGroup;
		ground = _ground;
	}
	override public function update(){
		super.update();
		spawnTimer += flixel.FlxG.elapsed;
		if (spawnTimer > 3){
			spawnTimer = 0;

			soldiers.add(new Soldier(x,y,ground));
		}
	}
}
