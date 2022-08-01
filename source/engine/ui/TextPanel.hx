package engine.ui;

import flixel.FlxG;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIText;
import flixel.text.FlxText;

class TextPanel extends Panel
{
	var textField(default, null):FlxUIText;
	var text:String;
	var textProgress:Float;
	var padding:Float;

	var writeSpeed = 24;
	var writeSpeedFast = 80;

	var choices = new Array<FlxUIButton>();

	var nextCallback:() -> Void;

	public function new(x:Float, y:Float, width:Float, height:Float, bg = AssetPaths.panel__png, ?slice9:Array<Int>)
	{
		if (slice9 == null)
			slice9 = [8, 8, 16, 16];
		padding = slice9[0];
		textField = new FlxUIText(padding, padding, width - padding * 2);
		textField.font = AssetPaths.LouisGeorgeCafe__ttf;
		textField.size = 32;
		super(x, y, width, height, bg, slice9);
		add(textField);
	}

	override function set_displayWidth(value:Float):Float
	{
		textField.fieldWidth = value - padding * 2;
		return super.set_displayWidth(value);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (textProgress < text.length)
		{
			textProgress += elapsed * (FlxG.keys.pressed.CONTROL ? writeSpeedFast : writeSpeed);
			textField.text = text.substr(0, Math.floor(textProgress));
		}
		else
		{
			if (nextCallback != null && FlxG.keys.justPressed.SPACE)
				nextCallback();
		}
	}

	public function setText(text:String, ?nextCallback:() -> Void)
	{
		clearChoices();
		this.text = text;
		this.nextCallback = nextCallback;
		textProgress = 0;
	}

	function clearChoices()
	{
		for (choice in choices)
		{
			remove(choice);
		}
		choices.resize(0);
	}

	public function setChoices(text:String, choiceLabels:Array<String>, callback:(Int) -> Void)
	{
		setText(text);
		textField.text = text;
		var yPos = textField.height + padding;
		var i = 0;
		for (choiceLabel in choiceLabels)
		{
			var i2 = i;
			var choice = new FlxUIButton(textField.x, yPos, choiceLabel, () -> callback(i2));
			choice.label.color = 0xffffffff;
			choice.loadGraphicSlice9([
				AssetPaths.button__png,
				AssetPaths.button_hover__png,
				AssetPaths.button_press__png
			], 24, 24, [[8, 8, 16, 16], [8, 8, 16, 16], [8, 8, 16, 16]]);
			choice.label.size = textField.size;
			choice.label.font = textField.font;
			choice.label.fieldWidth = 0;
			choice.resize(choice.label.width + 8, choice.label.height + 8);
			add(choice);
			choices.push(choice);
			++i;
			yPos += choice.height;
		}
		textField.text = "";
	}

	public function setFont(font:String)
	{
		textField.font = font;
	}
}
