extends Node
class_name WordFactory

@export var normal_world_scene : PackedScene
@export var blinking_word_scene : PackedScene
@export var multi_validation_word_scene : PackedScene


func create_normal_word(text: String, bbcode_effect: String) -> BaseWord:
	var normal_word = normal_world_scene.instantiate() as NormalWord
	normal_word.set_text(text)
	normal_word.set_bbcode_template("[%s]%%s[]" % bbcode_effect)
	normal_word.re_render()
	return normal_word

func create_blinking_word(text: String, bbcode_effect: String) -> BaseWord:
	var blinking_word = blinking_word_scene.instantiate() as BlinkingWord
	blinking_word.set_text(text)
	blinking_word.set_bbcode_template("[%s]%%s[]" % bbcode_effect)
	blinking_word.re_render()
	return blinking_word
	
func create_multivalidation_word(text: String, bbcode_effect: String, validations: int) -> BaseWord:
	var multi_validation_word = multi_validation_word_scene.instantiate() as MultiValidationWord
	multi_validation_word.health = validations
	multi_validation_word.set_text(text)
	multi_validation_word.set_bbcode_template("[%s]%%s[]" % bbcode_effect)
	multi_validation_word.re_render()
	return multi_validation_word
