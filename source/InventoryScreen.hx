import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class InventoryScreen extends FlxSubState
{
	public static var CURRENT_ITEM:BlockID = BlockID.COBBLESTONE;

	var blackBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

	var inventoryBlocks:FlxTypedSpriteGroup<Block>;

	var transitioningIn:Bool = true;
	var transitioningOut:Bool = false;

	var camObj:FlxObject;

	var blockText:FlxText;

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

		var i = 0;
		for (b in BlockManager.getBlockList())
		{
			var block = BlockManager.getNewBlock(b);
			block.screenCenter();
			block.alpha = 0;
			block.x = -block.width;
			block.ID = i;

			FlxTween.tween(block, {alpha: 1, x: 32 + (i * (block.width * 2))}, 0.5, {
				ease: FlxEase.quadInOut,
				startDelay: block.ID * 0.05
			});

			inventoryBlocks.add(block);

			i++;
		}

		blockText = new FlxText();
		blockText.cameras = [PlayState.CAM_HUD];

		blockText.size = 24;

		add(blockText);

		blockText.alpha = 0;

		FlxTween.cancelTweensOf(blockText);
		FlxTween.tween(blockText, {alpha: 1}, 1, {
			ease: FlxEase.quadInOut
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([A, LEFT]) && !transitioningOut)
			CURRENT_ITEM.add(-1);
		if (FlxG.keys.anyJustPressed([D, RIGHT]) && !transitioningOut)
			CURRENT_ITEM.add(1);

		CURRENT_ITEM.minMax(0, BlockManager.getBlockList().length - 1);
		PlayState.PLAYER.blockID = CURRENT_ITEM;

		FlxG.watch.addQuick('CURRENT_ITEM', CURRENT_ITEM);

		blockText.text = CURRENT_ITEM.toString();
		blockText.screenCenter();
		blockText.y += blockText.height * 1.5;

		for (block in inventoryBlocks.members)
		{
			FlxG.watch.addQuick('block (${block.blockID})', block.blockID);

			if (CURRENT_ITEM.compare(block.blockID))
			{
				block.scale.set(Block.SCALE * 1.5, Block.SCALE * 1.5);
				camObj.x = block.getGraphicMidpoint().x;
			}
			else
				block.scale.set(Block.SCALE, Block.SCALE);
		}

		if (FlxG.keys.justPressed.E && (!transitioningIn && !transitioningOut))
		{
			trace('New item: $CURRENT_ITEM');

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

			FlxTween.cancelTweensOf(blockText);
			FlxTween.tween(blockText, {alpha: 0}, 1, {
				ease: FlxEase.quadInOut
			});
		}
	}
}
