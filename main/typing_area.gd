extends LineEdit

func _ready() -> void:
	grab_focus.call_deferred()
	text_submitted.connect(_on_text_submitted)
	text_changed.connect(_on_text_changed)
	EventBus.phase_changed.connect(_on_phase_changed)
	
func _on_text_submitted(new_text: String) -> void:
	EventBus.word_submitted.emit(new_text.json_escape())
	text = ""
	
func _on_text_changed(new_text: String) -> void:
	EventBus.letter_typed.emit(new_text.json_escape())

func _on_phase_changed() -> void:
	text = ""