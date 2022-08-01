package engine;

import engine.ui.TextPanel;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import haxe.Exception;

private class StopException extends Exception
{
	public function new()
	{
		super("STOP");
	}
}

class VisualNovelEngine extends FlxGroup
{
	var history = new Array<Dynamic>();
	var historyPos = 0;
	var story:(VisualNovelEngine) -> Void;

	public var textPanel = new TextPanel(0, FlxG.height - FlxG.height * 0.3, FlxG.width, FlxG.height * 0.3);

	public function new(story:(VisualNovelEngine) -> Void)
	{
		super();
		this.story = story;
		add(textPanel);
		next();
	}

	public function setFont(font:String)
	{
		textPanel.setFont(font);
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

	override function update(elapsed:Float)
	{
		super.update(elapsed);
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
		stop();
		return ret;
	}

	function addHistory(ret:Dynamic)
	{
		history.push(ret);
		return ret;
	}
}
