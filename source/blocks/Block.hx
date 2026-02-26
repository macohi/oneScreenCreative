package blocks;

import flixel.FlxSprite;

class Block extends FlxSprite
{
	public static var SCALE:Float = 2;
	public static var BLOCK_SIZE:Int = 16;

	public var blockID(default, set):BlockID = 0;

	function set_blockID(newID:BlockID):BlockID
	{
		loadGraphic('assets/blocks.png', true, BLOCK_SIZE, BLOCK_SIZE);
		animation.add('block', [BlockManager.blocksJSON?.blocks[newID.toInt()]?.frame ?? 0], 24);
		animation.play('block');

		return blockID = newID;
	}

	public static var BLOCK_DIMENSION(get, never):Int;

	static function get_BLOCK_DIMENSION():Int
		return Math.round(BLOCK_SIZE * SCALE);

	override public function new(blockID:BlockID, ?x:Float, ?y:Float)
	{
		super(x, y);

		this.blockID = blockID;

		this.scale.set(SCALE, SCALE);
		updateHitbox();
	}
}
