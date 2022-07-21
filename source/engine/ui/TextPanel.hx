package engine.ui;

import flixel.addons.ui.FlxUIText;
import flixel.text.FlxText;

class TextPanel extends Panel
{
	public var text(default, null):FlxUIText;

	var padding:Float;

	public function new(x:Float, y:Float, width:Float, height:Float, bg = AssetPaths.panel__png, ?slice9:Array<Int>)
	{
		if (slice9 == null)
			slice9 = [8, 8, 16, 16];
		padding = slice9[0];
		text = new FlxUIText(padding, padding, width - padding * 2);
		text.font = AssetPaths.LouisGeorgeCafe__ttf;
		super(x, y, width, height, bg, slice9);
		add(text);
	}

	override function set_displayWidth(value:Float):Float
	{
		text.fieldWidth = value - padding * 2;
		return super.set_displayWidth(value);
	}
}
