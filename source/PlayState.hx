package;

import flixel.math.FlxPoint;
import openfl.Assets;
import lime.system.System;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flixel.FlxState;

class PlayState extends FlxState
{
	var beginning:Date = Date.now();
	var rng:FlxRandom = null;
	var frameCount:Int = 0;
	var frameCountFlxText:FlxText = null;
	var boardFlxBitMapText:Array<FlxBitmapText> = [];
	var boardFlxText:Array<FlxText> = [];
	var useBitmap = true;

	override public function create()
	{
		super.create();

		var ps2pLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ
abcdefghijklmnopqrstuvwxyz
1234567890
\"!`?'.,;:()[]{}<>|/@\\^$-%+=#_&~*";
		var textBytes = Assets.getText(AssetPaths.ps2p__fnt);
		var XMLData = Xml.parse(textBytes);
		// this does not seem to work, runtime error:
		// Segmentation fault (core dumped)
		// var fontAngleCode = FlxBitmapFont.fromAngelCode(AssetPaths.ps2p__png, XMLData);  
	
		var fontSize = FlxPoint.get(16, 16);
		var fontMonoSpace = FlxBitmapFont.fromMonospace(AssetPaths.ps2p16__png, ps2pLetters, fontSize);
		this.rng = new FlxRandom();
		var letters = ['z', 'x', 'c', ' '];
		
		for (x in 0...40)
		{
			for (y in 0...40)
			{
				var letter = letters[this.rng.int(0, letters.length - 1)];
				if (! useBitmap) {
					var flxLetter = new FlxText(y * 10, x * 14, FlxG.width, letter, 14);
					add(flxLetter);
					this.boardFlxText.push(flxLetter);
				}
				else {					
					var bitmapText = new FlxBitmapText(fontMonoSpace);
					bitmapText.x = y * 16;
					bitmapText.y = x * 16;
					bitmapText.text = letter;
					add(bitmapText);
					this.boardFlxBitMapText.push(bitmapText);
				}
			}
		}
		
		
		var text = new FlxText(0, 0, FlxG.width, "Hello Mom!", 64);
		text.setFormat(null, 64, FlxColor.RED, FlxTextAlign.CENTER);
		add(text);
		frameCountFlxText = new FlxText(0, 128, FlxG.width, Std.string(frameCount), 32);
		frameCountFlxText.setFormat(null, 64, FlxColor.RED, FlxTextAlign.CENTER);
		add(frameCountFlxText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		frameCount++;
		if ((Date.now().getTime() - beginning.getTime()) / 1000 > 10)
		{
			trace('Game exited with framecount: ' + frameCount);
			System.exit(0);
		}
		
		var letters = ['z', 'x', 'c', ' '];
		for (x in 0...40)
		{
			for (y in 0...40)
			{
				if (! useBitmap) {
					// this.boardFlxText[y * 40 + x].text = letters[this.rng.int(0, letters.length - 1)];
				} else {
					this.boardFlxBitMapText[y * 40 + x].text = letters[this.rng.int(0, letters.length - 1)];
				}
			}
		}
		
		frameCountFlxText.text = Std.string(frameCount);
		
	}
}
