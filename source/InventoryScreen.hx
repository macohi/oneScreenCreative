import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class InventoryScreen extends FlxSubState
{
	public static var CURRENT_ITEM:Int = 1;

	var blockCount:Int = 2;

	var blackBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

	var inventoryBlocks:FlxTypedSpriteGroup<Block>;

	override function create()
	{
		super.create();

		blackBG.alpha = 0;
		add(blackBG);
		blackBG.screenCenter();

		FlxTween.tween(blackBG, {alpha: .75}, 1, {ease: FlxEase.quadInOut});

		inventoryBlocks = new FlxTypedSpriteGroup<Block>();
		add(inventoryBlocks);

		var b = 0;
		while (b < blockCount)
		{
			var block = new Block(b, 0, 0);
			block.screenCenter();
			block.alpha = 0;
			block.x = FlxG.camera.x - (block.width * 4);
			block.ID = b;

			FlxTween.tween(block, {alpha: 1, x: 32 + (b * (block.width * 2))}, 0.5, {
				ease: FlxEase.quadInOut,
				startDelay: block.ID * 0.1
			});

			inventoryBlocks.add(block);

			b++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		for (block in inventoryBlocks.members)
		{
			if (CURRENT_ITEM == block.id)
				block.colorTransform.redMultiplier = block.colorTransform.greenMultiplier = block.colorTransform.blueMultiplier = 1.1;
			else
				block.colorTransform.redMultiplier = block.colorTransform.greenMultiplier = block.colorTransform.blueMultiplier = 1.0;
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			for (block in inventoryBlocks.members)
				FlxTween.tween(block, {alpha: 0, x: FlxG.camera.x - (block.width * 4)}, 0.5, {
					ease: FlxEase.quadInOut,
					startDelay: block.ID * 0.1
				});

			FlxTween.tween(blackBG, {alpha: 0}, 1, {
				ease: FlxEase.quadInOut,
				onComplete: tween ->
				{
					close();
				}
			});
		}
	}
}
