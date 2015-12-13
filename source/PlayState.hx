package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var ground:FlxSprite;
	var farm:Farm;
	var castle:Castle;
	var loaded:Bool = false;
	var soldiers:FlxTypedGroup<Soldier>;
	var farmers:FlxTypedGroup<Farmer>;
	var fungi:FlxTypedGroup<Fungi>;
	var thorns:FlxTypedGroup<Thorn>;
	var projectiles:FlxGroup;

	var player:Farmer;

	var money = 0;
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		flixel.FlxG.scaleMode = new ScaleMode();
		FlxG.camera.bgColor = flixel.util.FlxColor.WHITE;

		ground = new FlxSprite(0,FlxG.height-30);
		ground.immovable = true;
		ground.makeGraphic(FlxG.width,30,flixel.util.FlxColor.GREEN);
		add(ground);

		soldiers = new FlxTypedGroup<Soldier>();
		farmers = new FlxTypedGroup<Farmer>();
		fungi = new FlxTypedGroup<Fungi>();
		thorns = new FlxTypedGroup<Thorn>();
		projectiles = new FlxGroup();

		castle = new Castle(1100,FlxG.height-30-160,soldiers,ground,projectiles);
		add(castle);

		farm = new Farm(30,FlxG.height-30-160,farmers);
		add(farm);

		add(farmers);
		add(soldiers);
		add(fungi);
		add(thorns);
		add(projectiles);

		player = new Farmer(farm.x,farm.y);
		farmers.add(player);
		FlxG.camera.follow(player);


		FlxG.worldBounds.set(1300,FlxG.height*2);
		FlxG.camera.bounds = new flixel.util.FlxRect(0,0,1300,FlxG.height);

		loaded=true;

	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		farm.destroy();
		castle.destroy();
		ground.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();

		flixel.FlxG.collide(ground,soldiers);
		flixel.FlxG.collide(ground,farmers);



		if (FlxG.keys.justPressed.SHIFT){
			fungi.add(new Fungi(player.x+ 16-(20/2), player.y+20,ground,soldiers));
		}
		if (FlxG.keys.justPressed.Q){
			thorns.add(new Thorn(player.x+ 16-(20/2), player.y,ground,soldiers));
		}


		/*
		if (FlxG.mouse.screenX < 35){
			FlxG.camera.x += FlxG.elapsed*55;
		}
		if (FlxG.mouse.screenX > FlxG.width-35){
			FlxG.camera.x -= FlxG.elapsed*55;
		}*/

		/*ground.y = flixel.FlxG.height-30;
		ground.makeGraphic(FlxG.width,30,flixel.util.FlxColor.GREEN);
		add(ground);*/
	}

	override public function onResize (width,height){
		super.onResize(width,height);

		FlxG.camera.scroll.y = (-height/FlxG.camera.zoom)+height;
		FlxG.camera.bounds = new flixel.util.FlxRect(0,(-height/FlxG.camera.zoom)+height,1300,(height/FlxG.camera.zoom));

		if (loaded){
			ground.y = height-30;
			ground.width=width;
			//ground.makeGraphic(width,30,flixel.util.FlxColor.GREEN);
			ground.scale.x = width;
			ground.updateHitbox();
			//add(ground);

			castle.y = height-30-160;
			farm.y = height-30-160;
		}
	}
}
