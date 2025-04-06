extends BaseWord

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, .2)
	tween.tween_property(self, "modulate:a", 1, .2)
	tween.set_loops()