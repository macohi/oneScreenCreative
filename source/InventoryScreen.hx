import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
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

	var blockCount:Int = 2;

	var whiteBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height);
	
	var inventoryBlocks:FlxTypedSpriteGroup<Block>;

	override function create()
	{
		super.create();

		whiteBG.alpha = 0;
		add(whiteBG);
		whiteBG.screenCenter();

		FlxTween.tween(whiteBG, {alpha: .5}, 0.15, {ease: FlxEase.quadInOut});

		inventoryBlocks = new FlxTypedSpriteGroup<Block>();
		add(inventoryBlocks);

		var b = 0;
		while (b < blockCount)
		{
			var block = new Block(b, 0, 0);
			block.screenCenter();
			block.x = 32 + (b * (block.width * 2));

			inventoryBlocks.add(block);

			b++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			for (block in inventoryBlocks.members)
				FlxTween.tween(block, {alpha: 0, y: -96}, 0.1, {
					ease: FlxEase.quadInOut
				});

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
