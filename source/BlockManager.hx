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

	public static function getNewBlock(blockID:BlockID, ?x:Float, ?y:Float, ?debugMode:Bool):Block
	{
		if (blockID == 5)
			return new BlockTreeTrunk(x, y, debugMode);

		if (blockID.compare(5)) blockID.add(1);

		return new Block(blockID, x, y, debugMode);
	}
}
