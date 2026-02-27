package;

import flixel.math.FlxPoint;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.FlxState;
import blocks.Block;

class PlayState extends FlxState
{
	public static var instance:PlayState;

	var width:Int = Math.floor(FlxG.width / Block.BLOCK_DIMENSION);
	var height:Int = Math.floor(FlxG.height / Block.BLOCK_DIMENSION) + 1;

	var blocks:FlxTypedSpriteGroup<Block>;

	public static var PLAYER:Block;

	public static var CAM_GAME:FlxCamera;
	public static var CAM_HUD:FlxCamera;
	public static var CAM_INVENTORY:FlxCamera;

	override public function create()
	{
		super.create();

		instance = null;
		instance = this;

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

		reloadPlayer();

		// generateBasicWorld();

		World.parseWorldString('sx0_sy0_i1r10_i-1r10');
	}

	public static function reloadPlayer()
	{
		var prevPos = FlxPoint.get();

		if (PLAYER != null)
		{
			prevPos.set(PLAYER.x, PLAYER.y);

			instance.members.remove(PLAYER);
			PLAYER.destroy();
		}
		else
		{
			var x = (Math.floor(instance.height / 2) - 1) * Block.BLOCK_DIMENSION;
			var y = (Math.floor(instance.width / 2) - 1) * Block.BLOCK_DIMENSION;

			PLAYER.setPosition(x, y);
		}

		PLAYER = BlockManager.getNewBlock(InventoryScreen.CURRENT_ITEM, prevPos.x, prevPos.y, true);
		instance.add(PLAYER);
		PLAYER.cameras = [CAM_GAME];

		PLAYER.alpha = .5;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([A, S, W, D, LEFT, DOWN, UP, RIGHT]))
		{
			if (FlxG.keys.anyJustPressed([A, LEFT]))
				PLAYER.x -= Block.BLOCK_DIMENSION;
			if (FlxG.keys.anyJustPressed([D, RIGHT]))
				PLAYER.x += Block.BLOCK_DIMENSION;

			if (FlxG.keys.anyJustPressed([W, UP]))
				PLAYER.y -= Block.BLOCK_DIMENSION;
			if (FlxG.keys.anyJustPressed([S, DOWN]))
				PLAYER.y += Block.BLOCK_DIMENSION;

			if (PLAYER.x < 0)
				PLAYER.x = 0;
			if (PLAYER.x > (width * Block.BLOCK_DIMENSION) - Block.BLOCK_DIMENSION)
				PLAYER.x = (width * Block.BLOCK_DIMENSION) - Block.BLOCK_DIMENSION;

			if (PLAYER.y < 0)
				PLAYER.y = 0;
			if (PLAYER.y > (height * Block.BLOCK_DIMENSION) - Block.BLOCK_DIMENSION)
				PLAYER.y = (height * Block.BLOCK_DIMENSION) - Block.BLOCK_DIMENSION;
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
				}
				else if (overlappingBlock)
					continue;

			if (!overlappingBlock)
				blocks.add(BlockManager.getNewBlock(InventoryScreen.CURRENT_ITEM, PLAYER.x, PLAYER.y));
		}

		if (FlxG.keys.justPressed.E)
			openSubState(new InventoryScreen());
	}

	public function generateBasicWorld()
	{
		var w = 0;
		var h = 0;

		while (h < height)
		{
			w = 0;
			while (w < width)
			{
				var x = w * Block.BLOCK_DIMENSION;
				var y = h * Block.BLOCK_DIMENSION;

				if (h >= Math.floor(height / 2))
				{
					var block:BlockID = (h == Math.floor(height / 2)) ? 0 : 1;

					var newblock = new Block(block, x, y);
					blocks.add(newblock);
				}

				w++;
			}

			h++;
		}

		trace('Generated Basic World! (${blocks.members.length} blocks)');
	}
}
