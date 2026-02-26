enum abstract BlockID(Int) from Int to Int
{
	public function compare(against:BlockID)
		return this == against;

	public function toInt()
		return this;

	public function toString()
	{
		return BlockManager.blocksJSON?.blocks[toInt()]?.name ?? 'Unknown';
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
}
