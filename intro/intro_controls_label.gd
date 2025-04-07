extends RichTextLabel

func _ready() -> void:
	var tween: Tween = create_tween().set_loops()
	tween.tween_property(self, "modulate:a", 0, 1)
	tween.tween_property(self, "modulate:a", 1, 1)