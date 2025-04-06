extends Control

@export var main_menu_scene: PackedScene
@export var main_scene: PackedScene

var main_menu_instance: MainMenu
var main_instance: Main

func _ready() -> void:
	main_menu_instance = main_menu_scene.instantiate() as MainMenu
	add_child(main_menu_instance)
	EventBus.start_game_clicked.connect(_on_start_game_clicked)

func _on_start_game_clicked() -> void:
	print("start_game")
	main_instance = main_scene.instantiate() as Main
	remove_child(main_menu_instance)
	add_child(main_instance)
