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
		textPanel.text.size = 32;
		next();
	}

	public function setFont(font:String)
	{
		textPanel.text.font = font;
	}

	public function showText(text:String)
	{
		if (hasHistory())
			return getHistory();
		textPanel.text.text = text;
		return addHistory(true);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.SPACE)
			next();
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

	function hasHistory()
	{
		return historyPos < history.length;
	}

	function getHistory()
	{
		return history[historyPos++];
	}

	function addHistory(ret:Dynamic)
	{
		history.push(ret);
		throw new StopException();
		return ret;
	}
}
