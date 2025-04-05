extends StaticBody2D

class_name Word

var player: Player

@export var label: RichTextLabel

func _ready() -> void:
	add_to_group(&"words")

func _process(_delta: float) -> void:
	pass
	
func set_text(text: String) -> void:
	label.text = text
