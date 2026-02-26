import blocks.*;
import lime.utils.Assets;
import haxe.Json;

class BlockManager
{
	public static var blocksJSON:BlocksJSON;

	public static function initBlocksStuff()
	{
		blocksJSON = Json.parse(Assets.getText('assets/blocks.json'));
	}

	public static function getNewBlock(blockID:BlockID, ?x:Float, ?y:Float):Block
	{
		if (blockID == 5)
			return new BlockTreeTrunk(x, y);

		if (blockID.compare(5)) blockID.add(1);

		return new Block(blockID, x, y);
	}
}
