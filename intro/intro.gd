extends Control

class_name Intro

var text: Array[String] = [
						  "A lonely writer, longing for inspiration",
						  "Meditating, stimulating their imagination",
						  "And lo and behold, it is working",
						  "As always, the depths of the mind are worth exploring",
						  "",
						  "Beware however, the darker places",
						  "And always stay clear, of strange faces",
						  "Some words perhaps, are beyond understanding",
						  "Yet if you persist, you shall finally see the ending",
						  "",
						  "Insight is ever a poisonous gift",
						  "One one hand, the veil of the arcane, it can lift",
						  "On the other, monsters that lurk in the depths, it can invite",
						  "Devouring reason and sanity, in the darkness of the night",
						  "",
						  ]

@export var label_container: VBoxContainer
@export var intro_label_scene: PackedScene

var typing_tween: Tween
var fading_tween: Tween

func _ready() -> void:
	process_intro()

func _input(event: InputEvent) -> void:
	# todo show controls in UI
	if event.is_action_pressed(&"process_intro"):
		if (!typing_tween or !typing_tween.is_valid()) and (!fading_tween or !fading_tween.is_valid()):
			process_intro()
	if event.is_action_pressed(&"skip_intro"):
		if typing_tween:
			typing_tween.pause()
		if fading_tween:
			fading_tween.pause()
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
