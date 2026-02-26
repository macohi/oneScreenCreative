package blocks;

import flixel.FlxG;

class BlockTreeTrunk extends Block
{
	override function set_blockID(newID:BlockID):BlockID
	{
		loadGraphic('assets/blocks.png', true, Block.BLOCK_SIZE, Block.BLOCK_SIZE);
		if (debugMode) animation.add('block', [5, 6], 2);
		if (!debugMode) animation.add('block', [FlxG.random.int(5, 6)], 24);
		animation.play('block');

		return blockID = newID;
	}

	override public function new(?x:Float, ?y:Float, ?debugMode:Bool)
	{
		super(5, x, y, debugMode);
	}
}
