extends Control

@export var label: RichTextLabel

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	label.text = label.text.replace("%total_counter%", str(Stats.total_counter))
	label.text = label.text.replace("%max_combo%", str(Stats.max_combo))
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"retry"):
		EventBus.retry_requested.emit()