package;

import lime.utils.Assets;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;

using StringTools;

class Main extends Sprite
{
	public function new()
	{
		super();

		BlockManager.initBlocksStuff();

		addChild(new FlxGame(0, 0, PlayState));

		final tracks:Array<String> = Assets.getText('assets/tracks.txt').split('\n');

		if (tracks.length < 1)
			return;

		for (i => track in tracks)
			tracks[i] = track.trim();

		FlxG.signals.postUpdate.add(function()
		{
			if (FlxG.sound.music?.playing)
				return;
			if (!FlxG.random.bool(FlxG.random.float(0, 15)))
				return;

			FlxG.sound.playMusic('assets/tracks/${tracks[FlxG.random.int(0, tracks.length - 1)]}.wav', 1.0, false);
			FlxG.sound.music.fadeIn(1, 0, 1, function(t) {});
		});
	}
}
