import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.math.FlxMath;
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

	var blockCount:Int = 3;

	var blackBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

	var inventoryBlocks:FlxTypedSpriteGroup<Block>;

	var transitioningIn:Bool = true;
	var transitioningOut:Bool = false;

	var camObj:FlxObject;

	override function create()
	{
		super.create();

		camObj = new FlxObject(0, FlxG.height / 2);
		add(camObj);

		PlayState.CAM_INVENTORY.follow(camObj, LOCKON, 0.4);

		blackBG.alpha = 0;
		add(blackBG);
		blackBG.screenCenter();
		blackBG.cameras = [PlayState.CAM_HUD];

		FlxTween.cancelTweensOf(blackBG);
		FlxTween.tween(blackBG, {alpha: .75}, 1, {
			ease: FlxEase.quadInOut,
			onComplete: tween ->
			{
				transitioningIn = false;
			}
		});

		inventoryBlocks = new FlxTypedSpriteGroup<Block>();
		add(inventoryBlocks);
		inventoryBlocks.cameras = [PlayState.CAM_INVENTORY];

		var b = 0;
		while (b < blockCount)
		{
			var block = new Block(b, 0, 0);
			block.screenCenter();
			block.alpha = 0;
			block.x = -block.width;
			block.ID = b;

			FlxTween.tween(block, {alpha: 1, x: 32 + (b * (block.width * 2))}, 0.5, {
				ease: FlxEase.quadInOut,
				startDelay: block.ID * 0.05
			});

			inventoryBlocks.add(block);

			b++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([A, LEFT]))
			CURRENT_ITEM = FlxMath.maxAdd(CURRENT_ITEM, -1, blockCount - 1, 0);
		if (FlxG.keys.anyJustPressed([D, RIGHT]))
			CURRENT_ITEM = FlxMath.maxAdd(CURRENT_ITEM, 1, blockCount - 1, 0);

		for (block in inventoryBlocks.members)
		{
			if (CURRENT_ITEM == block.blockID)
			{
				block.scale.set(Block.SCALE * 1.5, Block.SCALE * 1.5);
				camObj.x = block.x;
			}
			else
				block.scale.set(Block.SCALE, Block.SCALE);
		}

		if (FlxG.keys.justPressed.E && !transitioningIn && !transitioningOut)
		{
			trace(CURRENT_ITEM);
			transitioningOut = true;

			for (block in inventoryBlocks.members)
				FlxTween.tween(block, {alpha: 0, x: -block.width}, 0.5, {
					ease: FlxEase.quadInOut,
					startDelay: block.ID * 0.05
				});

			FlxTween.cancelTweensOf(blackBG);
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
