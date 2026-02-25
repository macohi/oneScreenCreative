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

		generateWorld();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
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
	}
}
