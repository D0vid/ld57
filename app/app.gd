extends Control

@export var main_menu_scene: PackedScene
@export var main_scene: PackedScene
@export var intro_scene: PackedScene
@export var transition_rect: ColorRect

var main_menu_instance: MainMenu
var intro_instance: Intro
var main_instance: Main

func _ready() -> void:
	main_menu_instance = main_menu_scene.instantiate() as MainMenu
	add_child(main_menu_instance)
	EventBus.start_game_clicked.connect(_on_start_game_clicked)
	EventBus.intro_finished.connect(_on_intro_finished)

func _on_start_game_clicked() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(transition_rect, "color:a", 1, 1)
	tween.tween_callback(_start_intro).set_delay(1)
	tween.tween_property(transition_rect, "color:a", 0, 2.5)
	
func _on_intro_finished() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(transition_rect, "color:a", 1, 1)
	tween.tween_callback(_start_game).set_delay(1)
	tween.tween_property(transition_rect, "color:a", 0, 2.5)

func _start_intro() -> void:
	intro_instance = intro_scene.instantiate() as Intro
	remove_child(main_menu_instance)
	add_child(intro_instance)

func _start_game() -> void:
	main_instance = main_scene.instantiate() as Main
	remove_child(intro_instance)
	add_child(main_instance)
