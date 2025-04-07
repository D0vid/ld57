@tool
extends RichTextEffectBase
## Swap a letter by another one

## [letterswap][]
var bbcode := "letterswap"



func _process_custom_fx(c: CharFXTransform) -> bool:
	var cs := get_char_size(c) * Vector2(0.5, -0.3)
	var speed := 10.0
	var pulse := pow(maxf(sin(c.elapsed_time * speed), 0.0) * maxf(sin(c.elapsed_time * 2.0 * speed), 0.0), 4.0)
	c.transform *= Transform2D.IDENTITY.translated(cs)
	c.transform *= Transform2D.IDENTITY.scaled(Vector2.ONE + Vector2(1.4, 0.8) * pulse)
	c.transform *= Transform2D.IDENTITY.translated(-cs)

	var target_char: String = str(c.env.get("char", " "))
	

	if c.elapsed_time > .2:
		set_char(c, target_char)

	return true
