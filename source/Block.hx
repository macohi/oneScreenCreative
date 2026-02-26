import BlockManager.BlockID;
import flixel.FlxSprite;

class Block extends FlxSprite
{
	public static var SCALE:Float = 2;
	public static var BLOCK_SIZE:Int = 16;

	public var blockID(default, set):BlockID = 0;

	function set_blockID(newID:BlockID):BlockID
	{
		loadGraphic('assets/blocks.png', true, BLOCK_SIZE, BLOCK_SIZE);
		animation.add('block', [newID], 24);
		animation.play('block');

		this.scale.set(SCALE, SCALE);
		updateHitbox();

		return newID;
	}

	override public function new(blockID:BlockID, ?x:Float, ?y:Float)
	{
		super(x, y);

		this.blockID = blockID;
	}
}
