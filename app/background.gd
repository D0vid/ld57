extends ColorRect

var transition_time_sec = 5

func _ready() -> void:
	EventBus.phase_changed.connect(_on_phase_changed)

func _on_phase_changed(phase: WordManager.Phase) -> void:
	if phase == WordManager.Phase.EASY:
		transition_to_easy()
	elif phase == WordManager.Phase.MEDIUM:
		transition_to_medium()
	elif phase == WordManager.Phase.NIGHTMARE:
		transition_to_nightmare()

func transition_to_easy() -> void:
	var tween: Tween = create_tween().set_parallel(true)
	tween.tween_property(self, "material:shader_parameter/spin_rotation_speed", 0.1, transition_time_sec).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "material:shader_parameter/move_speed", 1.0, transition_time_sec).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "material:shader_parameter/colour_1", Color(0.73, 0.80, 1.00), transition_time_sec)
	tween.tween_property(self, "material:shader_parameter/colour_2", Color(1.00, 0.78, 1.00), transition_time_sec)
	tween.tween_property(self, "material:shader_parameter/colour_3", Color.WHITE, transition_time_sec)

func transition_to_medium() -> void:
	var tween: Tween = create_tween().set_parallel(true)
	tween.tween_property(self, "material:shader_parameter/spin_rotation_speed", 0.25, transition_time_sec).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "material:shader_parameter/move_speed", 5.0, transition_time_sec).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "material:shader_parameter/colour_1", Color(0.48, 0.60, 0.55), transition_time_sec)
	tween.tween_property(self, "material:shader_parameter/colour_2", Color(0.83, 0.75, 0.63), transition_time_sec)
	tween.tween_property(self, "material:shader_parameter/colour_3", Color.WHITE, transition_time_sec)

func transition_to_nightmare() -> void:
	var tween: Tween = create_tween().set_parallel(true)
	tween.tween_property(self, "material:shader_parameter/spin_rotation_speed", 0.5, transition_time_sec).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "material:shader_parameter/move_speed", 10.0, transition_time_sec).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "material:shader_parameter/colour_1", Color(0.60, 0.10, 0.18), transition_time_sec)
	tween.tween_property(self, "material:shader_parameter/colour_2", Color(0.37, 0.03, 0.40), transition_time_sec)
	tween.tween_property(self, "material:shader_parameter/colour_3", Color(0.17, 0.17, 0.17), transition_time_sec)
	
