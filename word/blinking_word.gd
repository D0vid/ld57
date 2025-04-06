extends BaseWord

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 1)
	tween.tween_property(self, "modulate:a", 1, 1)
	tween.set_loops()