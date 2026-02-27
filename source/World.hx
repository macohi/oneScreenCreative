import blocks.Block;

using StringTools;

class World
{
	public static var FORMAT_NUMBER:Int = 3;

	public static var BASIC_WORLD_STRING:String = 'f2_i0x0y11_i0x1y11_i0x2y11_i0x3y11_i0x4y11_i0x5y11_i0x6y11_i0x7y11_i0x8y11_i0x9y11_i0x10y11_i0x11y11_i0x12y11_i0x13y11_i0x14y11_i0x15y11_i0x16y11_i0x17y11_i0x18y11_i0x19y11_i0x20y11_i0x21y11_i0x22y11_i0x23y11_i0x24y11_i0x25y11_i0x26y11_i0x27y11_i0x28y11_i0x29y11_i0x30y11_i0x31y11_i0x32y11_i0x33y11_i0x34y11_i0x35y11_i0x36y11_i0x37y11_i0x38y11_i0x39y11_i1x0y12_i1x1y12_i1x2y12_i1x3y12_i1x4y12_i1x5y12_i1x6y12_i1x7y12_i1x8y12_i1x9y12_i1x10y12_i1x11y12_i1x12y12_i1x13y12_i1x14y12_i1x15y12_i1x16y12_i1x17y12_i1x18y12_i1x19y12_i1x20y12_i1x21y12_i1x22y12_i1x23y12_i1x24y12_i1x25y12_i1x26y12_i1x27y12_i1x28y12_i1x29y12_i1x30y12_i1x31y12_i1x32y12_i1x33y12_i1x34y12_i1x35y12_i1x36y12_i1x37y12_i1x38y12_i1x39y12_i1x0y13_i1x1y13_i1x2y13_i1x3y13_i1x4y13_i1x5y13_i1x6y13_i1x7y13_i1x8y13_i1x9y13_i1x10y13_i1x11y13_i1x12y13_i1x13y13_i1x14y13_i1x15y13_i1x16y13_i1x17y13_i1x18y13_i1x19y13_i1x20y13_i1x21y13_i1x22y13_i1x23y13_i1x24y13_i1x25y13_i1x26y13_i1x27y13_i1x28y13_i1x29y13_i1x30y13_i1x31y13_i1x32y13_i1x33y13_i1x34y13_i1x35y13_i1x36y13_i1x37y13_i1x38y13_i1x39y13_i1x0y14_i1x1y14_i1x2y14_i1x3y14_i1x4y14_i1x5y14_i1x6y14_i1x7y14_i1x8y14_i1x9y14_i1x10y14_i1x11y14_i1x12y14_i1x13y14_i1x14y14_i1x15y14_i1x16y14_i1x17y14_i1x18y14_i1x19y14_i1x20y14_i1x21y14_i1x22y14_i1x23y14_i1x24y14_i1x25y14_i1x26y14_i1x27y14_i1x28y14_i1x29y14_i1x30y14_i1x31y14_i1x32y14_i1x33y14_i1x34y14_i1x35y14_i1x36y14_i1x37y14_i1x38y14_i1x39y14_i1x0y15_i1x1y15_i1x2y15_i1x3y15_i1x4y15_i1x5y15_i1x6y15_i1x7y15_i1x8y15_i1x9y15_i1x10y15_i1x11y15_i1x12y15_i1x13y15_i1x14y15_i1x15y15_i1x16y15_i1x17y15_i1x18y15_i1x19y15_i1x20y15_i1x21y15_i1x22y15_i1x23y15_i1x24y15_i1x25y15_i1x26y15_i1x27y15_i1x28y15_i1x29y15_i1x30y15_i1x31y15_i1x32y15_i1x33y15_i1x34y15_i1x35y15_i1x36y15_i1x37y15_i1x38y15_i1x39y15_i1x0y16_i1x1y16_i1x2y16_i1x3y16_i1x4y16_i1x5y16_i1x6y16_i1x7y16_i1x8y16_i1x9y16_i1x10y16_i1x11y16_i1x12y16_i1x13y16_i1x14y16_i1x15y16_i1x16y16_i1x17y16_i1x18y16_i1x19y16_i1x20y16_i1x21y16_i1x22y16_i1x23y16_i1x24y16_i1x25y16_i1x26y16_i1x27y16_i1x28y16_i1x29y16_i1x30y16_i1x31y16_i1x32y16_i1x33y16_i1x34y16_i1x35y16_i1x36y16_i1x37y16_i1x38y16_i1x39y16_i1x0y17_i1x1y17_i1x2y17_i1x3y17_i1x4y17_i1x5y17_i1x6y17_i1x7y17_i1x8y17_i1x9y17_i1x10y17_i1x11y17_i1x12y17_i1x13y17_i1x14y17_i1x15y17_i1x16y17_i1x17y17_i1x18y17_i1x19y17_i1x20y17_i1x21y17_i1x22y17_i1x23y17_i1x24y17_i1x25y17_i1x26y17_i1x27y17_i1x28y17_i1x29y17_i1x30y17_i1x31y17_i1x32y17_i1x33y17_i1x34y17_i1x35y17_i1x36y17_i1x37y17_i1x38y17_i1x39y17_i1x0y18_i1x1y18_i1x2y18_i1x3y18_i1x4y18_i1x5y18_i1x6y18_i1x7y18_i1x8y18_i1x9y18_i1x10y18_i1x11y18_i1x12y18_i1x13y18_i1x14y18_i1x15y18_i1x16y18_i1x17y18_i1x18y18_i1x19y18_i1x20y18_i1x21y18_i1x22y18_i1x23y18_i1x24y18_i1x25y18_i1x26y18_i1x27y18_i1x28y18_i1x29y18_i1x30y18_i1x31y18_i1x32y18_i1x33y18_i1x34y18_i1x35y18_i1x36y18_i1x37y18_i1x38y18_i1x39y18_i1x0y19_i1x1y19_i1x2y19_i1x3y19_i1x4y19_i1x5y19_i1x6y19_i1x7y19_i1x8y19_i1x9y19_i1x10y19_i1x11y19_i1x12y19_i1x13y19_i1x14y19_i1x15y19_i1x16y19_i1x17y19_i1x18y19_i1x19y19_i1x20y19_i1x21y19_i1x22y19_i1x23y19_i1x24y19_i1x25y19_i1x26y19_i1x27y19_i1x28y19_i1x29y19_i1x30y19_i1x31y19_i1x32y19_i1x33y19_i1x34y19_i1x35y19_i1x36y19_i1x37y19_i1x38y19_i1x39y19_i1x0y20_i1x1y20_i1x2y20_i1x3y20_i1x4y20_i1x5y20_i1x6y20_i1x7y20_i1x8y20_i1x9y20_i1x10y20_i1x11y20_i1x12y20_i1x13y20_i1x14y20_i1x15y20_i1x16y20_i1x17y20_i1x18y20_i1x19y20_i1x20y20_i1x21y20_i1x22y20_i1x23y20_i1x24y20_i1x25y20_i1x26y20_i1x27y20_i1x28y20_i1x29y20_i1x30y20_i1x31y20_i1x32y20_i1x33y20_i1x34y20_i1x35y20_i1x36y20_i1x37y20_i1x38y20_i1x39y20_i1x0y21_i1x1y21_i1x2y21_i1x3y21_i1x4y21_i1x5y21_i1x6y21_i1x7y21_i1x8y21_i1x9y21_i1x10y21_i1x11y21_i1x12y21_i1x13y21_i1x14y21_i1x15y21_i1x16y21_i1x17y21_i1x18y21_i1x19y21_i1x20y21_i1x21y21_i1x22y21_i1x23y21_i1x24y21_i1x25y21_i1x26y21_i1x27y21_i1x28y21_i1x29y21_i1x30y21_i1x31y21_i1x32y21_i1x33y21_i1x34y21_i1x35y21_i1x36y21_i1x37y21_i1x38y21_i1x39y21_i1x0y22_i1x1y22_i1x2y22_i1x3y22_i1x4y22_i1x5y22_i1x6y22_i1x7y22_i1x8y22_i1x9y22_i1x10y22_i1x11y22_i1x12y22_i1x13y22_i1x14y22_i1x15y22_i1x16y22_i1x17y22_i1x18y22_i1x19y22_i1x20y22_i1x21y22_i1x22y22_i1x23y22_i1x24y22_i1x25y22_i1x26y22_i1x27y22_i1x28y22_i1x29y22_i1x30y22_i1x31y22_i1x32y22_i1x33y22_i1x34y22_i1x35y22_i1x36y22_i1x37y22_i1x38y22_i1x39y22_';

	public static function parseWorldString(world:String)
	{
		var game:PlayState = PlayState.instance;

		var blockData:Array<Dynamic> = [];

		var format:Int = 0;

		var variation:Int = 0;

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
					variation: variation
				};
				variation = 0;

				for (oblock in blockData)
					if (oblock.x == block.x && oblock.y == block.y)
						continue;

				trace(block);
				blockData.push(block);
			}
		}

		for (block in blockData)
		{
			var newBlock:Block = BlockManager.getNewBlock(block.id, block.x * Block.BLOCK_DIMENSION, block.y * Block.BLOCK_DIMENSION, false, block.variation);
			game.blocks.add(newBlock);
		}

		trace('Generated String World! (${blockData.length} blocks)');
	}

	public static function generateWorldString():String
	{
		var game:PlayState = PlayState.instance;
		var world:String = 'f${FORMAT_NUMBER}_';

		for (block in game.blocks)
		{
			var v = 'v${block.variation}';
			var i = 'i${block.blockID.toInt()}';
			var x = 'x${Math.floor(block.x / Block.BLOCK_DIMENSION)}';
			var y = 'y${Math.floor(block.y / Block.BLOCK_DIMENSION)}';

			world += '${v}${i}${x}${y}_';
		}

		trace('Generated String World Key: $world');
		return world;
	}
}
