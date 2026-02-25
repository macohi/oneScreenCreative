import flixel.FlxSprite;

class Block extends FlxSprite
{
	public var id:Int = 0;

	override public function new(id:Int, ?x:Float, ?y:Float)
	{
		super(x, y);

		this.id = id;

		loadGraphic('assets/blocks.png', true, 16, 16);
		animation.add('block', [this.id], 24);
		animation.play('block');
	}
}
