import flixel.graphics.frames.FlxFrame;
import flixel.graphics.FlxGraphic;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class InventoryScreen extends FlxSubState
{
	public static var CURRENT_ITEM:Int = 0;
	public static var BLOCK_COUNT:Int = 0;

	var whiteBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height);

	override function create()
	{
		super.create();

		whiteBG.alpha = 0;
		add(whiteBG);
		whiteBG.screenCenter();

		FlxTween.tween(whiteBG, {alpha: .5}, 0.15, {ease: FlxEase.quadInOut});

		if (BLOCK_COUNT > 0)
			return;

		var graphics:Array<FlxFrame> = [];
		var stopGettingGraphics:Bool = false;

		var i = 0;
		while (!stopGettingGraphics)
		{
			var b = new Block(i, 0, 0);

			stopGettingGraphics = b.frame == null || graphics.contains(b.frame);

			if (!graphics.contains(b.frame))
				graphics.push(b.frame);

			i++;
		}

		BLOCK_COUNT = graphics.length;
		trace('Got $BLOCK_COUNT blocks!');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxTween.tween(whiteBG, {alpha: 0}, 0.15, {
				ease: FlxEase.quadInOut,
				onComplete: tween ->
				{
					close();
				}
			});
		}
	}
}
