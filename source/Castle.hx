package ;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;

class Castle extends FlxSprite {
	var spawnTimer:Float = 0;
	var soldiers:FlxTypedGroup<Soldier>;
	var ground:FlxSprite;
	var projectiles:FlxGroup;

	public function new (X,Y,soldierGroup:FlxTypedGroup<Soldier>,_ground:FlxSprite,_projectiles:FlxGroup){
		super(X,Y);
		loadGraphic("assets/images/Castle.png",192,160,true);

		soldiers = soldierGroup;
		ground = _ground;
		projectiles = _projectiles;
	}
	override public function update(){
		super.update();
		spawnTimer += flixel.FlxG.elapsed;
		if (spawnTimer > 3){
			spawnTimer = 0;

			soldiers.add(new Soldier(x,y,ground,projectiles));
		}
	}
}
