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
		add(engine.group);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function story(vn:VisualNovelEngine)
	{
		vn.setBackground(AssetPaths.Castle__jpg);
		var random = vn.getRandom(0, 6);
		vn.showText("Your value is " + random);
		vn.showText("Your value is still " + random);
		vn.showText("Your value is again " + random);
		var choice = vn.showChoices("what do you like?", ["Apples", "Oranges"]);
		vn.showText("Lorem Ipsum Dolor Est ");
		vn.showText("3");
		vn.setFont(AssetPaths.Castle_2__jpg);
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
		vn.setBackground(AssetPaths.Forest_2__jpg);
		vn.showText("6");
	}
}
