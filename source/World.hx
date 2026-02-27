import blocks.Block;

using StringTools;

class World
{
	public static var FORMAT_NUMBER:Int = 4;

	public static var BASIC_WORLD_STRING:String = 'f4_r39v0i0x0y11_r439v0i1x0y22_';

	static var blockData:Array<Dynamic> = [];
	static var variation:Int = 0;

	public static function parseWorldString(world:String)
	{
		var game:PlayState = PlayState.instance;

		var format:Int = 0;

		blockData = [];
		variation = 0;

		trace('Parsing String World: $world');

		for (piece in world.split('_'))
		{
			trace(piece);

			if (piece.startsWith('f') && format < 1)
			{
				format = Std.parseInt(piece.substr(1));
				trace('Format #$format');
			}

			if (piece.startsWith('v'))
				variation = Std.parseInt(piece.substr(1));

			if (piece.startsWith('r'))
			{
				var count = 0;

				while (count < Std.parseInt(piece.split('i')[0].substr(1)))
				{
					parseBlockWorldString('i' + piece.split('i')[1], count);
					count++;
				}
			}

			if (piece.startsWith('i'))
				parseBlockWorldString(piece);
		}

		for (block in blockData)
		{
			var newBlock:Block = BlockManager.getNewBlock(block.id, block.x * Block.BLOCK_DIMENSION, block.y * Block.BLOCK_DIMENSION, false, block.variation);
			game.blocks.add(newBlock);
		}

		trace('Generated String World! (${blockData.length} blocks)');
	}

	static function parseBlockWorldString(piece:String, xAdd:Int = 0)
	{
		var game:PlayState = PlayState.instance;

		piece = piece.substr(1);

		var blockID = Std.parseInt(piece.split('x')[0]);
		var blockX = Std.parseInt(piece.split('x')[1].split('y')[0]) + xAdd;
		var blockY = Std.parseInt(piece.split('x')[1].split('y')[1]);

		if (blockID < 0)
			return;

		if (blockX > game.width)
		{
			var ogX = blockX;

			blockY += Math.floor(blockX / game.width);
			blockX = blockX % game.width;
			
			trace('x overload ($ogX > ${game.width})');
			trace(' * nx: $blockX ($ogX % ${game.width})');
			trace(' * ny: $blockY (+ ${Math.floor(ogX / game.width)})');
		}

		if (blockY > game.height)
			blockY = blockY % game.height;

		var block = {
			id: blockID,
			x: blockX,
			y: blockY,
			variation: variation
		};
		variation = 0;

		for (oblock in blockData)
			if (oblock.x == block.x && oblock.y == block.y)
				continue;

		// trace(block);
		blockData.push(block);
	}

	public static function generateWorldString():String
	{
		var game:PlayState = PlayState.instance;
		var world:String = 'f${FORMAT_NUMBER}_';

		var v = '';
		var r = '';
		var rval = 0;
		var id = '';
		var x = '';
		var y = '';

		var blockMembers = game.blocks.members;

		for (i => block in blockMembers)
		{
			var append = true;

			v = 'v${block.variation}';
			id = 'i${block.blockID.toInt()}';
			if (x == '' || rval == 0)
				x = 'x${Math.floor(block.x / Block.BLOCK_DIMENSION)}';
			y = 'y${Math.floor(block.y / Block.BLOCK_DIMENSION)}';

			if (blockMembers[i + 1]?.blockID?.toInt() == block.blockID.toInt())
			{
				rval++;
				r = 'r$rval';
				append = false;
			}
			else
			{
				append = true;
			}

			if (append)
			{
				world += '${r}${v}${id}${x}${y}_';
				r = '';
				rval = 0;
			}
		}

		trace('Generated String World Key: $world');
		return world;
	}
}
