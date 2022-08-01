package;

import engine.VisualNovelEngine;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	var engine:VisualNovelEngine;

	override public function create()
	{
		super.create();
		engine = new VisualNovelEngine(story);
		add(engine);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function story(vn:VisualNovelEngine)
	{
		var choice = vn.showChoices("what do you like?", ["Apples", "Oranges"]);
		vn.showText("Lorem Ipsum Dolor Est ");
		vn.showText("3");
		vn.setFont(AssetPaths.LouisGeorgeCafe__ttf);
		vn.showText("So you like " + choice);
		if (vn.showQuestion("Question"))
		{
			vn.showText("true");
			vn.showText("5");
		}
		else
		{
			vn.showText("false");
		}
		vn.showText("6");
	}
}
