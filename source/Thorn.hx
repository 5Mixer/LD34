package ;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

class Thorn extends FlxSprite {
	var ground:FlxSprite;
	public var size = 1;

	public var collisionExceptions = new flixel.group.FlxGroup();

	var growTimer:Float = 0;
	var noGrowTime = 0.0;

	var soldiers:FlxTypedGroup<Soldier>;

	var slowdown = 0.75;

	public function new (X,Y,_ground,soldierGroup:FlxTypedGroup<Soldier>){
		super(X,Y);
		loadGraphic("assets/images/Thorns.png",40,40,true);

		immovable = true;
		ground = _ground;

		animation.add("1",[0]);
		animation.add("2",[1]);
		animation.add("3",[2]);
		animation.add("4",[3]);
		animation.add("5",[4]);

		soldiers = soldierGroup;
	}
	override public function update (){
		super.update();

		flixel.FlxG.collide(this,ground);

		flixel.FlxG.overlap(this,soldiers,function (fungi,soldier){
			if (collisionExceptions.members.indexOf(soldier) == -1){
				var s = cast(soldier,Soldier);

				if (flixel.util.FlxRandom.chanceRoll(75)){
					s.kill();
				}else{
					s.speed = Std.int(s.speed*slowdown);
				}

				fungi.decreaseSize();
				fungi.collisionExceptions.add(s);
				noGrowTime = 2;
				//soldier.kill();
			}
		});

		growTimer += flixel.FlxG.elapsed;

		if (noGrowTime > 0) noGrowTime -= flixel.FlxG.elapsed;

		if (growTimer > 2 && size < 5 && noGrowTime < 0.01){
			growTimer = 0;
			size++;
		}

		animation.play(size+"");

		if (size < 1){
			kill();
		}

	}

	public function decreaseSize (){
		size--;
	}
}
