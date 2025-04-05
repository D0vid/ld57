extends Area2D

class_name Word

@export var label: RichTextLabel

func _ready() -> void:
	add_to_group(&"words")
	
func _process(_delta: float) -> void:
	pass
	
func set_text(text: String) -> void:
	label.text = text

func get_text() -> String:
	return label.text