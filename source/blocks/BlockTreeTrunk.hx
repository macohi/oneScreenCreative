package blocks;

import flixel.FlxG;

class BlockTreeTrunk extends Block
{
	override function set_blockID(newID:BlockID):BlockID
	{
		loadGraphic('assets/blocks.png', true, Block.BLOCK_SIZE, Block.BLOCK_SIZE);
		animation.add('block', [FlxG.random.int(newID, newID + 1)], 24);
		animation.play('block');

		return blockID = newID;
	}

	override public function new(?x:Float, ?y:Float)
	{
		super(5, x, y);
	}
}
