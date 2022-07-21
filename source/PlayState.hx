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
		vn.showText("Lorem Ipsum Dolor Est Bla Blub BlaLorem Ipsum Dolor Est Bla Blub BlaLorem Ipsum Dolor Est Bla Blub BlaLorem Ipsum Dolor Est Bla Blub Bla");
		vn.showText("3");
		vn.setFont(AssetPaths.LouisGeorgeCafe__ttf);
		vn.showText("4");
		if (vn.showText("Question"))
		{
			vn.showText("true");
		}
	}
}
