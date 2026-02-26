package;

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	var width:Int = Math.floor(FlxG.width / (Block.BLOCK_SIZE * Block.SCALE));
	var height:Int = Math.floor(FlxG.height / (Block.BLOCK_SIZE * Block.SCALE)) + 1;

	var blocks:FlxTypedSpriteGroup<Block>;

	public static var PLAYER:Block;

	public static var CAM_GAME:FlxCamera;
	public static var CAM_HUD:FlxCamera;
	public static var CAM_INVENTORY:FlxCamera;

	override public function create()
	{
		super.create();

		CAM_GAME = new FlxCamera();
		CAM_HUD = new FlxCamera();
		CAM_INVENTORY = new FlxCamera();
		FlxG.cameras.add(CAM_GAME);
		FlxG.cameras.add(CAM_HUD);
		FlxG.cameras.add(CAM_INVENTORY);
		CAM_HUD.bgColor.alpha = 0;
		CAM_INVENTORY.bgColor.alpha = 0;

		blocks = new FlxTypedSpriteGroup<Block>();
		add(blocks);
		blocks.cameras = [CAM_GAME];

		PLAYER = BlockManager.getNewBlock(InventoryScreen.CURRENT_ITEM, 0,0);
		add(PLAYER);
		PLAYER.cameras = [CAM_GAME];

		PLAYER.alpha = .5;

		generateWorld();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([A, S, W, D, LEFT, DOWN, UP, RIGHT]))
		{
			if (FlxG.keys.anyJustPressed([A, LEFT]))
				PLAYER.x -= PLAYER.width;
			if (FlxG.keys.anyJustPressed([D, RIGHT]))
				PLAYER.x += PLAYER.width;

			if (FlxG.keys.anyJustPressed([W, UP]))
				PLAYER.y -= PLAYER.height;
			if (FlxG.keys.anyJustPressed([S, DOWN]))
				PLAYER.y += PLAYER.height;

			if (PLAYER.x < 0)
				PLAYER.x = 0;
			if (PLAYER.x > (width * (Block.BLOCK_SIZE * Block.SCALE)) - PLAYER.width)
				PLAYER.x = (width * (Block.BLOCK_SIZE * Block.SCALE)) - PLAYER.width;

			if (PLAYER.y < 0)
				PLAYER.y = 0;
			if (PLAYER.y > (height * (Block.BLOCK_SIZE * Block.SCALE)) - PLAYER.height)
				PLAYER.y = (height * (Block.BLOCK_SIZE * Block.SCALE)) - PLAYER.height;
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			var overlappingBlock:Bool = false;

			for (block in blocks.members)
				if (PLAYER.overlaps(block))
				{
					overlappingBlock = true;

					blocks.members.remove(block);
					block.destroy();
				} else if (overlappingBlock) continue;

			if (!overlappingBlock)
				blocks.add(BlockManager.getNewBlock(InventoryScreen.CURRENT_ITEM, PLAYER.x, PLAYER.y));
		}

		if (FlxG.keys.justPressed.E)
			openSubState(new InventoryScreen());
	}

	public function generateWorld()
	{
		var w = 0;
		var h = 0;

		while (h < height)
		{
			w = 0;
			while (w < width)
			{
				var x = w * (Block.BLOCK_SIZE * Block.SCALE);
				var y = h * (Block.BLOCK_SIZE * Block.SCALE);

				if (h >= Math.floor(height / 2))
				{
					var block = (h == Math.floor(height / 2)) ? 0 : 1;

					var newblock = new Block(block, x, y);
					blocks.add(newblock);
				}

				if (h == Math.floor(height / 2) - 1)
					if (w == Math.floor(width / 2))
						PLAYER.setPosition(x, y);

				w++;
			}

			h++;
		}

		trace('Generated world! (${blocks.members.length} blocks)');
	}
}
