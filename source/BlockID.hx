enum abstract BlockID(Int) from Int to Int
{
	var GRASS_BLOCK = 0;
	var COBBLESTONE = 1;
	var PLANKS = 2;
	var DIRT = 3;
	var TREE_LEAVES = 4;
	var TREE_TRUNK = 5;

	public function compare(against:BlockID)
		return this == against;

	public function toInt()
		return this;

	public function toString()
	{
		return switch (this)
		{
			default: 'Unknown';
			
			case GRASS_BLOCK: 'Grass Block';
			case COBBLESTONE: 'Cobblestone';
			case PLANKS: 'Planks';
			case DIRT: 'Dirt Block';
			case TREE_LEAVES: 'Tree Leaves';
			case TREE_TRUNK: 'Tree Trunk';
		}
	}

	public inline function minMax(min:Int, max:Int)
	{
		if (this < min)
			this = min;
		if (this > max)
			this = max;
	}

	public inline function add(amount:Int)
		this += amount;

	public static function list()
		return [GRASS_BLOCK, COBBLESTONE, PLANKS, DIRT, TREE_LEAVES, TREE_TRUNK,];
}
