package ;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;

class HealthBar extends FlxSpriteGroup {
	var fg:FlxSprite;
	var bg:FlxSprite;

	public function new (X,Y){
		super(X,Y);

		bg = new FlxSprite(X,Y);
		bg.makeGraphic(20,3,flixel.util.FlxColor.RED,true);
		add(bg);

		fg = new FlxSprite(X,Y);
		fg.makeGraphic(20,3,flixel.util.FlxColor.GREEN,true);
		fg.origin.set(0,0);
		add(fg);
	}
	public function setValue(value:Float){
		fg.scale.x = value;
	}
	public function move(x,y){
		bg.x = fg.x = x;
		bg.y = fg.y = y;
	}

}
