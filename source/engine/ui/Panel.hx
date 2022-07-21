package engine.ui;

import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIGroup;
import openfl.geom.Rectangle;

class Panel extends FlxUIGroup
{
	public var displayWidth(default, set):Float;
	public var displayHeight(default, set):Float;

	var background:FlxUI9SliceSprite;

	public function new(x:Float, y:Float, width:Float, height:Float, bg = AssetPaths.panel__png, ?slice9:Array<Int>)
	{
		super();
		background = new FlxUI9SliceSprite(0, 0, bg, new Rectangle(0, 0, width, height), slice9);
		this.x = x;
		this.y = y;
		this.displayWidth = width;
		this.displayHeight = height;
		if (slice9 == null)
			slice9 = [8, 8, 16, 16];
		add(background);
	}

	function set_displayWidth(value:Float):Float
	{
		if (displayWidth != value)
		{
			displayWidth = value;
			background.resize(displayWidth, displayHeight);
		}
		return displayWidth;
	}

	function set_displayHeight(value:Float):Float
	{
		if (displayHeight != value)
		{
			displayHeight = value;
			background.resize(displayWidth, displayHeight);
		}
		return displayHeight;
	}
}
