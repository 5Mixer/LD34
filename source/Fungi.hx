package ;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

class Fungi extends FlxSprite {
	var ground:FlxSprite;
	public var size = 1;

	public var collisionExceptions = new flixel.group.FlxGroup();

	var growTimer:Float = 0;

	var soldiers:FlxTypedGroup<Soldier>;

	public function new (X,Y,_ground,soldierGroup:FlxTypedGroup<Soldier>){
		super(X,Y);
		loadGraphic("assets/images/PlantA.png",20,20,true);

		immovable = true;
		ground = _ground;

		soldiers = soldierGroup;
	}
	override public function update (){
		super.update();

		flixel.FlxG.collide(this,ground);

		flixel.FlxG.overlap(this,soldiers,function (fungi,soldier){
			if (collisionExceptions.members.indexOf(soldier) == -1){
				var s = cast(soldier,Soldier);
				s.speed = Std.int(s.speed/2);
				fungi.decreaseSize();
				fungi.collisionExceptions.add(s);
				//soldier.kill();
			}
		});

		growTimer += flixel.FlxG.elapsed;
		if (growTimer > 3){
			growTimer = 0;
			size++;
		}

		if (size < 1){
			kill();
		}

	}

	public function decreaseSize (){
		size--;
	}
}
