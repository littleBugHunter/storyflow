package engine.ui;

import flixel.FlxG;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUISprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Stage extends FlxUIGroup
{
	var background:FlxUISprite;

	public function new()
	{
		super(0, 0);
		background = new FlxUISprite(0, 0);
		add(background);
	}

	public function setBackground(image:FlxGraphicAsset)
	{
		background.loadGraphic(image);
		background.origin.set(0, 0);
		var ratio = background.frameWidth / background.frameHeight;
		if (ratio > FlxG.width / FlxG.height)
		{
			var scale = FlxG.height / background.frameHeight;
			background.scale.set(scale, scale);
			background.setPosition((FlxG.width - background.frameWidth * scale) / 2, 0);
		}
		else
		{
			var scale = FlxG.width / background.frameWidth;
			background.scale.set(scale, scale);
			background.setPosition(0, (FlxG.height - background.frameHeight * scale) / 2);
		}
	}
}
