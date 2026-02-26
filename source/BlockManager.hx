class BlockManager
{
	public static function getBlockList():Array<BlockID>
		return BlockID.list();

	public static function getNewBlock(blockID:BlockID, ?x:Float, ?y:Float):Block
		return new Block(blockID, x, y);
}
