package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	var width:Int = Math.floor(FlxG.width / (Block.BLOCK_SIZE * Block.SCALE));
	var height:Int = Math.floor(FlxG.height / (Block.BLOCK_SIZE * Block.SCALE)) + 1;

	var blocks:FlxTypedSpriteGroup<Block>;

	var player:FlxSprite;

	override public function create()
	{
		super.create();

		blocks = new FlxTypedSpriteGroup<Block>();
		add(blocks);

		player = new FlxSprite();
		add(player);

		player.makeGraphic(Block.BLOCK_SIZE, Block.BLOCK_SIZE);
		player.scale.set(Block.SCALE, Block.SCALE);
		player.updateHitbox();
		player.alpha = .5;

		generateWorld();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([A, S, W, D, LEFT, DOWN, UP, RIGHT]))
		{
			if (FlxG.keys.anyJustPressed([A, LEFT]))
				player.x -= player.width;
			if (FlxG.keys.anyJustPressed([D, RIGHT]))
				player.x += player.width;

			if (FlxG.keys.anyJustPressed([W, UP]))
				player.y -= player.height;
			if (FlxG.keys.anyJustPressed([S, DOWN]))
				player.y += player.height;

			if (player.x < 0)
				player.x = 0;
			if (player.x > (width * (Block.BLOCK_SIZE * Block.SCALE)) - player.width)
				player.x = (width * (Block.BLOCK_SIZE * Block.SCALE)) - player.width;

			if (player.y < 0)
				player.y = 0;
			if (player.y > (height * (Block.BLOCK_SIZE * Block.SCALE)) - player.height)
				player.y = (height * (Block.BLOCK_SIZE * Block.SCALE)) - player.height;
		}
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
						player.setPosition(x, y);

				w++;
			}

			h++;
		}

		trace('Generated world! (${blocks.members.length} blocks)');
	}
}
