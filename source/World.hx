using StringTools;

class World
{
	// sx0_sy0_i1r10_i-1r10

	public static function parseWorldString(world:String)
	{
		var game:PlayState = PlayState.instance;

		var x:Int = 0;
		var y:Int = 0;

		trace('Parsing world: $world');

		for (piece in world.split('_'))
		{
			trace(piece);

			if (piece.startsWith('s'))
			{
				var symbol = piece.substr(1, 1);
				var int = Std.parseInt(piece.substr(2));

				trace('STARTING $symbol : $int');
			}
		}
	}
}
