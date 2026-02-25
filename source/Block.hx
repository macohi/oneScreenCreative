import flixel.FlxSprite;

class Block extends FlxSprite
{
	public static var SCALE:Float = 2;
	public static var BLOCK_SIZE:Int = 16;

	public var id:Int = 0;

	override public function new(id:Int, ?x:Float, ?y:Float)
	{
		super(x, y);

		this.id = id;

		loadGraphic('assets/blocks.png', true, BLOCK_SIZE, BLOCK_SIZE);
		animation.add('block', [this.id], 24);
		animation.play('block');

		this.scale.set(SCALE,SCALE);
		updateHitbox();
	}
}
