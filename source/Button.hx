package ;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxAngle;
import flixel.util.FlxMath;
import flixel.FlxG;

import msignal.Signal;

import flash.geom.Rectangle;

import flixel.text.FlxText;
import flixel.util.FlxColor;

import flixel.plugin.MouseEventManager;

import flixel.addons.ui.FlxUI9SliceSprite;

class Button extends FlxTypedGroup<FlxSprite>  {

	public var width:Float = 1;
	public var height:Float = 1;

	public var x:Int;
	public var y:Int;

	private var padding:Int = 5;

	private var needsResizing:Bool = false;

	public var background:FlxUI9SliceSprite;

	public var textField:FlxText;
	public var onClick = new Signal0();

	private var backgroundNeedsResizing:Bool=true;

	public var sigHoverEnter = new Signal0();
	public var sigHoverExit = new Signal0();

	public function new (_x,_y,text,_onClick){
		super();
		x=_x;
		y=_y;

		if (onClick!=null) onClick.add(_onClick); //Allow a deafault function to be called on click.

		// This is a basic 9-slice image with default skin
		background = new FlxUI9SliceSprite(x,y, "assets/images/Button.png", new Rectangle(5,5,10,10),[5,5,10,10]);

		add(background);

		textField = new FlxText(x+3,y+1);
		textField.text = text;
		textField.setFormat("assets/fonts/Fairfax.ttf", 12, FlxColor.WHITE, "left");
		textField.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 1);
		add(textField);

		width = background.width;
		height = background.height;


		MouseEventManager.add(background, onMouseDown, onMouseUp, onMouseOver, onMouseOut);


		forEach(function(spr:FlxSprite) {
			spr.scrollFactor.set();
		});
	}
	public function onMouseDown (s){

	}
	public function onMouseUp (s){
		//This is handled in the update method.
	}
	public function onMouseOver (s) {
		sigHoverEnter.dispatch();
	}
	public function onMouseOut (s){
		sigHoverExit.dispatch();
	}

	override public function update (){
		super.update();

		if (backgroundNeedsResizing){
			background.resize(textField.width+3,textField.height+3);

			width = background.width;
			height = background.height;

			if (background.width > 4){
				backgroundNeedsResizing=false;
			}
		}

		if (background.overlapsPoint(FlxG.mouse.getScreenPosition()) && FlxG.mouse.justReleased){
			onClick.dispatch();
			//FlxG.sound.play("assets/sounds/Beep.wav", 0.2, false);
		}
	}
	public function onWindowResize(x,y){
		background.setPosition(x,y);
		textField.setPosition(x+2,y+2);
	}
	public function setX (x){
		background.setPosition(x,background.y);
		textField.setPosition(x+2,textField.y);
	}
	public function setY (y){
		background.setPosition(background.x,y);
		textField.setPosition(textField.x,y+2);
	}
	public function tweenY (newY:Int,time:Float){
		FlxTween.tween(background, { y:newY }, time);
		FlxTween.tween(textField, { y:newY+2 }, time);
	}
}
