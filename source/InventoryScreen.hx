import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class InventoryScreen extends FlxSubState
{
	var whiteBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height);

	override function create()
	{
		super.create();

		whiteBG.alpha = 0;
		add(whiteBG);
		whiteBG.screenCenter();

		FlxTween.tween(whiteBG, {alpha: .5}, 0.3, {ease: FlxEase.quadInOut});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxTween.tween(whiteBG, {alpha: 0}, 0.3, {
				ease: FlxEase.quadInOut,
				onComplete: tween ->
				{
					close();
				}
			});
		}
	}
}
