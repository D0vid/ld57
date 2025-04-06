extends BaseWord
class_name BlinkingWord

func _ready() -> void:
	super()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, .1).set_delay(randf_range(0,.5))
	tween.tween_property(self, "modulate:a", 0, .3)
	tween.tween_property(self, "modulate:a", 1, .1)
	tween.tween_property(self, "modulate:a", 1, .5)
	tween.set_loops()
