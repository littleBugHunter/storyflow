package engine;

import engine.ui.Stage;
import engine.ui.TextPanel;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import haxe.Exception;

private class StopException extends Exception
{
	public function new()
	{
		super("STOP");
	}
}

class VisualNovelEngine
{
	var history = new Array<Dynamic>();
	var historyPos = 0;
	var story:(VisualNovelEngine) -> Void;

	public var group(default, null) = new FlxGroup();

	var textPanel = new TextPanel(0, FlxG.height - FlxG.height * 0.3, FlxG.width, FlxG.height * 0.3);
	var stage = new Stage();

	public function new(story:(VisualNovelEngine) -> Void)
	{
		this.story = story;
		group.add(stage);
		group.add(textPanel);
		next();
	}

	public function setFont(font:String)
	{
		if (hasHistory())
		{
			getHistory();
			return;
		}
		textPanel.setFont(font);
		addHistory(font);
	}

	public function showText(text:String)
	{
		if (hasHistory())
			return cast(getHistory());
		textPanel.setText(text, next);
		return cast(addHistoryAndStop(true));
	}

	public function showQuestion(text:String, positiveText = "Yes", negativeText = "No"):Bool
	{
		if (hasHistory())
			return cast(getHistory());
		textPanel.setChoices(text, [positiveText, negativeText], (i) ->
		{
			addHistory(i == 0);
			next();
		});
		stop();
		return cast(addHistoryAndStop(true));
	}

	public function showChoices(text:String, choices:Array<String>):String
	{
		if (hasHistory())
			return cast(getHistory());
		textPanel.setChoices(text, choices, (i) ->
		{
			addHistory(choices[i]);
			next();
		});
		stop();
		return cast(addHistoryAndStop("pending"));
	}

	public function getRandom(min:Int, max:Int):Int
	{
		if (hasHistory())
			return cast(getHistory());
		var value = FlxG.random.int(min, max);
		return cast(addHistory(value));
	}

	public function setBackground(background:FlxGraphicAsset)
	{
		if (hasHistory())
		{
			getHistory();
			return;
		}
		stage.setBackground(background);
		addHistory(background);
	}

	function next()
	{
		historyPos = 0;
		try
		{
			story(this);
		}
		catch (stop:StopException) {}
	}

	inline function stop()
	{
		throw new StopException();
	}

	function hasHistory()
	{
		return historyPos < history.length;
	}

	function getHistory()
	{
		return history[historyPos++];
	}

	function addHistoryAndStop(ret:Dynamic)
	{
		history.push(ret);
		historyPos++;
		stop();
		return ret;
	}

	function addHistory(ret:Dynamic)
	{
		history.push(ret);
		historyPos++;
		return ret;
	}
}
