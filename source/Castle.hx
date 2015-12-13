package ;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;

class Castle extends FlxSprite {
	var spawnTimer:Float = 0;
	var soldiers:FlxGroup;
	var ground:FlxSprite;
	var projectiles:FlxGroup;
	public var lives = 30;
	public var healthBar:HealthBar;

	public function new (X,Y,soldierGroup:FlxGroup,_ground:FlxSprite,_projectiles:FlxGroup){
		super(X,Y);
		loadGraphic("assets/images/Castle.png",192,160,true);

		healthBar = new HealthBar(getMidpoint().x,y);
		immovable = true;

		soldiers = soldierGroup;
		ground = _ground;
		projectiles = _projectiles;
	}
	override public function update(){
		super.update();
		healthBar.move(getMidpoint().x+4,getMidpoint().y);

		spawnTimer += flixel.FlxG.elapsed;
		if (spawnTimer > 3){
			spawnTimer = 0;
			if (Math.random() >0.75){

				soldiers.add(new Archer(x+20,y+height-32,ground,projectiles));
			}else{

				soldiers.add(new Soldier(x+20,y+height-32,ground));
			}
		}
	}
	public function decreaseLives (){
		lives--;
		healthBar.setValue(lives/30);
		if (lives == 0) kill();
	}
}
