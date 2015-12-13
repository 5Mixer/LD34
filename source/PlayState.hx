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
	var soldiers:FlxGroup;
	var farmers:FlxTypedGroup<Farmer>;
	var fungi:FlxTypedGroup<Fungi>;
	var thorns:FlxTypedGroup<Thorn>;
	var projectiles:FlxGroup;
	var cars:FlxGroup;

	var player:Farmer;

	public static var money = 100;
	var buyThorns:Button;
	var buyFungi:Button;

	var moneyText:FlxText;
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		flixel.FlxG.scaleMode = new ScaleMode();
		FlxG.camera.bgColor = flixel.util.FlxColor.WHITE;

		var background = new FlxSprite(0,-200);
		background.loadGraphic("assets/images/Background.png");
		background.scrollFactor.set(0.2,0.2);
		add(background);

		ground = new FlxSprite(0,FlxG.height-30);
		ground.immovable = true;
		ground.loadGraphic("assets/images/Ground.png"); //1300,30,flixel.util.FlxColor.GREEN
		add(ground);

		soldiers = new FlxGroup();
		farmers = new FlxTypedGroup<Farmer>();
		fungi = new FlxTypedGroup<Fungi>();
		thorns = new FlxTypedGroup<Thorn>();
		projectiles = new FlxGroup();
		cars = new FlxGroup();

		add(soldiers);

		castle = new Castle(1100,FlxG.height-30-160,soldiers,ground,projectiles);
		add(castle);
		add(castle.healthBar);

		add(cars);

		farm = new Farm(30,FlxG.height-30-160,farmers);
		add(farm);
		add(farm.healthBar);

		add(farmers);

		add(fungi);
		add(thorns);
		add(projectiles);


		player = new Farmer(farm.x,farm.y);
		farmers.add(player);
		add(player.healthBar);
		FlxG.camera.follow(player);


		FlxG.worldBounds.set(1300,FlxG.height*2);
		FlxG.camera.bounds = new flixel.util.FlxRect(0,0,1300,FlxG.height);

		loaded=true;


		buyThorns = new Button(50,40,"$30 - Buy killing thorns",function () {
			if (money > 29){
				money -= 30;
				thorns.add(new Thorn(player.x+ 16-(20/2), player.y,ground,soldiers));
			}
		});
		add(buyThorns);

		buyFungi = new Button(50,75,"$15 - Buy slowing fungi",function () {
			if (money > 14){
				money -= 15;
				fungi.add(new Fungi(player.x+ 16-(20/2), player.y+20,ground,soldiers));
			}
		});
		add(buyFungi);

		moneyText = new FlxText(20+3,20+1);
		moneyText.text = "$"+money;
		moneyText.setFormat(null, 16, flixel.util.FlxColor.WHITE, "left");
		moneyText.scrollFactor.set();
		add(moneyText);

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

		moneyText.text = "$"+money;

		flixel.FlxG.collide(ground,soldiers);
		flixel.FlxG.collide(ground,farmers);


		flixel.FlxG.collide(soldiers,farmers,function (s,f){
			s.kill();
			f.decreaseLives();
		});
		flixel.FlxG.collide(soldiers,cars,function (s,c){
			s.kill();
		});

		flixel.FlxG.collide(ground,projectiles,function (g,p){
			p.kill();
		});
		flixel.FlxG.collide(farmers,projectiles,function (f,p){
			p.kill();
			f.decreaseLives();
		});
		flixel.FlxG.collide(farm,projectiles,function (f,p){
			p.kill();
			f.decreaseLives();
		});
		flixel.FlxG.collide(castle,projectiles,function (f,p){
			p.kill();
			f.decreaseLives();
		});



		if (FlxG.keys.justPressed.SHIFT){
			fungi.add(new Fungi(player.x+ 16-(20/2), player.y+20,ground,soldiers));
		}
		if (FlxG.keys.justPressed.Q){
			thorns.add(new Thorn(player.x+ 16-(20/2), player.y,ground,soldiers));
		}
		if (FlxG.keys.justPressed.C){
			cars.add(new Car(farm.x + 30,farm.y+farm.height-20-20,ground));
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
		//FlxG.camera.bounds = new flixel.util.FlxRect(0,(-height/FlxG.camera.zoom)+height,1300,(height/FlxG.camera.zoom));

		if (loaded){
			//ground.y = height-30;

			//castle.y = height-30-160;
			//farm.y = height-30-160;
		}
	}
}
