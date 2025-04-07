extends Control

class_name Intro

var text: Array[String] = [
						  "In a dreamy realm, with thoughts flowing",
						  "Lies a blank page, silent and mocking",
						  "White as snow, it stares back",
						  "In emptiness, for inspiration you lack",
						  "",
						  "The cursor blinks, a steady beat,",
						  "Yet admitting defeat, the words retreat.",
						  "Ideas flutter, like ghosts in the night,",
						  "Elusive, fleeting, out of sight.",
						  "",
						  "Fear of failure, of not being right",
						  "Keeps the words locked in the night.",
						  "Perfection's shadow, a looming figure",
						  "Stifles the voice, makes the heart shiver",
						  "",
						  "But remember, dear writer, this is true,",
						  "The blank page is a friend, not a foe",
						  "It's a space for dreams, for thoughts to take flight,",
						  "A playground for words, in the soft moonlight.",
						  "",
						  "Beware however, the darker places",
						  "And always stay clear, of strange faces",
						  "Some words perhaps, are beyond understanding",
						  "Yet if you persist, you shall perhaps see the ending"
						  ]

@export var label_container: VBoxContainer
@export var intro_label_scene: PackedScene

var typing_tween: Tween
var fading_tween: Tween

func _ready() -> void:
	print('start intro')
	process_intro()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_accept") and (!typing_tween or !typing_tween.is_valid()) and (!fading_tween or !fading_tween.is_valid()):
		process_intro()
	if event.is_action_pressed(&"ui_cancel"):
		EventBus.intro_finished.emit()

func process_intro() -> void:
	if text.is_empty():
		EventBus.intro_finished.emit()
		return
	var label: RichTextLabel = intro_label_scene.instantiate()
	var sentence: String = text.pop_front()
	if sentence.is_empty():
		reset_label_container()
	else:
		label.visible_ratio = 0.0
		label_container.add_child(label)
		label.text = sentence
		typing_tween = create_tween()
		typing_tween.tween_property(label, "visible_ratio", 1.0, 1)
	
func reset_label_container() -> void:
	fading_tween = create_tween()
	fading_tween.tween_property(label_container, "modulate:a", 0, 1)
	fading_tween.tween_callback(_remove_children)
	fading_tween.tween_property(label_container, "modulate:a", 1, 0.1)
	fading_tween.tween_callback(process_intro)
	
func _remove_children() -> void:
	for child in label_container.get_children():
		label_container.remove_child(child)
		child.queue_free()