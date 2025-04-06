extends Control

class_name MainMenu

@export var start_game_btn: Button

func _ready() -> void:
	start_game_btn.pressed.connect(_on_start_game_pressed)
	
func _on_start_game_pressed() -> void:
	EventBus.start_game_clicked.emit()