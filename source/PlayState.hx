package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxState;

class PlayState extends FlxState
{
	var width:Int = 40;
	var height:Int = 30;

	var blocks:FlxTypedSpriteGroup<Block>;

	override public function create()
	{
		super.create();

		blocks = new FlxTypedSpriteGroup<Block>();
		add(blocks);

		var w = 0;
		var h = 0;

		while (h < height)
		{
			w = 0;
			while (w < width)
			{
				if (h >= 15)
				{
					var newblock = new Block(
						(h == 15) ? 0 : 1,
						w * (Block.BLOCK_SIZE * Block.SCALE),
						h * (Block.BLOCK_SIZE * Block.SCALE)
					);
					blocks.add(newblock);
				}

				w++;
			}

			h++;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
