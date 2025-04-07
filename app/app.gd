extends Control

@export var main_menu_scene: PackedScene
@export var main_scene: PackedScene
@export var intro_scene: PackedScene
@export var game_over_scene: PackedScene
@export var victory_scene: PackedScene
@export var transition_rect: ColorRect
@export var bg_layer: CanvasLayer

var main_menu_instance: MainMenu
var intro_instance: Intro
var main_instance: Main

var transition_tween: Tween

func _ready() -> void:
	main_menu_instance = main_menu_scene.instantiate() as MainMenu
	add_child(main_menu_instance)
	EventBus.start_game_clicked.connect(_on_start_game_clicked)
	EventBus.intro_finished.connect(_on_intro_finished)
	EventBus.retry_requested.connect(_on_retry_requested)
	EventBus.game_over.connect(_on_game_over)
	EventBus.victory.connect(_on_victory)

func _on_start_game_clicked() -> void:
	if transition_tween and transition_tween.is_running():
		transition_tween.stop()
	transition_tween = create_tween()
	transition_tween.tween_property(transition_rect, "color:a", 1, 1)
	transition_tween.tween_callback(_start_intro).set_delay(1)
	transition_tween.tween_property(transition_rect, "color:a", 0, 2.5)
	
func _on_intro_finished() -> void:
	if transition_tween and transition_tween.is_running():
		transition_tween.stop()
	transition_tween = create_tween()
	transition_tween.tween_property(transition_rect, "color:a", 1, 1)
	transition_tween.tween_callback(_start_game).set_delay(1)
	transition_tween.tween_property(transition_rect, "color:a", 0, 2.5)

func _start_intro() -> void:
	intro_instance = intro_scene.instantiate() as Intro
	remove_other_scenes([transition_rect, bg_layer])
	add_child(intro_instance)

func _start_game() -> void:
	main_instance = main_scene.instantiate() as Main
	remove_other_scenes([transition_rect, bg_layer])
	add_child(main_instance)

func _on_retry_requested() -> void:
	get_tree().set_pause(false)
	remove_other_scenes([transition_rect, bg_layer])
	main_instance = main_scene.instantiate() as Main
	add_child(main_instance)

func _on_game_over() -> void:
	remove_other_scenes([transition_rect, main_instance, bg_layer])
	var game_over: Node = game_over_scene.instantiate()
	add_child(game_over)
	get_tree().set_pause(true)

func _on_victory() -> void:
	remove_other_scenes([transition_rect, main_instance, bg_layer])
	var victory: Node = victory_scene.instantiate()
	add_child(victory)
	get_tree().set_pause(true)

func remove_other_scenes(scenes_to_ignore: Array[Node]) -> void:
	for child in get_children():
		if !scenes_to_ignore.has(child):
			remove_child(child)
			child.queue_free()
