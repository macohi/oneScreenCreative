enum abstract BlockID(Int) from Int to Int
{
	var GRASS_BLOCK = 0;
	var COBBLESTONE = 1;
	var PLANKS = 2;
	var DIRT = 3;
	var TREE_LEAVES = 4;
	var TREE_TRUNK = 6;

	public function toInt()
		return this;

	public static function getIDS()
		return [GRASS_BLOCK, COBBLESTONE, PLANKS, DIRT, TREE_LEAVES, TREE_TRUNK,];
}

class BlockManager
{
	public static function getBlockIDList():Array<BlockID>
		return BlockID.getIDS();

	public static function getNewBlock(blockID:BlockID, ?x:Float, ?y:Float):Block
		return new Block(blockID, x, y);
}
