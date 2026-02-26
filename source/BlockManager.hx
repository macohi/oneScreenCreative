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
		return new Block(blockID, x, y);
}
