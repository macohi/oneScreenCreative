import blocks.Block;

using StringTools;

class World
{
	// i1x0y0_i3x0y0
	public static function parseWorldString(world:String)
	{
		var game:PlayState = PlayState.instance;

		var x:Int = 0;
		var y:Int = 0;

		var blockData:Array<Dynamic> = [];

		trace('Parsing world: $world');

		for (piece in world.split('_'))
		{
			trace(piece);

			if (piece.startsWith('i'))
			{
				piece = piece.substr(1);

				var blockID = Std.parseInt(piece.split('x')[0]);
				var blockX = Std.parseInt(piece.split('x')[1].split('y')[0]);
				var blockY = Std.parseInt(piece.split('x')[1].split('y')[1]);

				if (blockID < 0)
					continue;

				var block = {
					id: blockID,
					x: blockX,
					y: blockY,
				};

				for (oblock in blockData)
					if (oblock.x == block.x && oblock.y == block.y)
						continue;

				trace(block);
				blockData.push(block);
			}
		}

		for (block in blockData)
		{
			var newBlock:Block = new Block(block.id, block.x, block.y, false);
			game.blocks.add(newBlock);
		}

		trace('Generated String World! (${blockData.length} blocks)');
	}
}
