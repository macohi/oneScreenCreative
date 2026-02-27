package blocks;

import flixel.FlxG;

class BlockTreeTrunk extends Block
{
	override function set_blockID(newID:BlockID):BlockID
	{
		if (debugMode)
		{
			loadGraphic('assets/blocks.png', true, Block.BLOCK_SIZE, Block.BLOCK_SIZE);
			animation.add('block', [5, 6], 2);
			animation.play('block');

			return blockID = newID;
		}
		else
			return super.set_blockID(newID);
	}

	override public function new(?x:Float, ?y:Float, ?debugMode:Bool, ?variation:Null<Int> = null)
	{
		super(5, x, y, debugMode, variation ?? FlxG.random.int(0, 1));
	}
}
