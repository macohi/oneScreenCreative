using StringTools;

class World
{
	// sx0_sy0_i1r10_i-1r10
	public static function parseWorldString(world:String)
	{
		var game:PlayState = PlayState.instance;

		var x:Int = 0;
		var y:Int = 0;

		var blockInfo:Array<Dynamic> = [];

		trace('Parsing world: $world');

		for (piece in world.split('_'))
		{
			if (x > game.width)
			{
				trace(Math.floor(x / game.width));
				y++;
			}

			trace(piece);

			if (piece.startsWith('s'))
			{
				var symbol = piece.substr(1, 1);
				var int = Std.parseInt(piece.substr(2));

				trace('STARTING $symbol : $int');

				if (symbol == 'x')
					x = int;
				if (symbol == 'y')
					y = int;
			}

			if (piece.startsWith('i'))
			{
				piece = piece.substr(1);

				var blockID = Std.parseInt(piece.split('r')[0]);
				var repeat = Std.parseInt(piece.split('r')[1]);

				trace('Block: $blockID : Repeat: $repeat');

				if (blockID < 0)
					x += repeat;
			}
		}
	}
}
