extends Area2D

class_name Word

enum WordStateEnum {
	MATCH,
	PARTIAL_MATCH,
	NO_MATCH
}

@export var label: RicherTextLabel

# Track progress
var time: float = 0.0
var frequency: int = 5     # How quickly the wave oscillates
var amplitude: float = 0.3     # How far the wave deviates

var unformatted_text: String
var bbcode_template: String

var submitted_valid_input: String

func _ready() -> void:
	add_to_group(&"words")
func _process(_delta: float) -> void:
	pass
	
func set_text(text: String) -> void:
	unformatted_text = text
	label.size = Vector2(label.size.x, text.length() * 10)
	
func set_bbcode_template(bbcode_template: String):
	self.bbcode_template = bbcode_template
	
func re_render() -> void:
	label.bbcode = bbcode_template % unformatted_text
	
func reset() -> void:
	submitted_valid_input = ""
	

func get_text() -> String:
	return unformatted_text
	
func move_toward(destination: Vector2, delta: float, speed: int) -> void:
	if position.distance_to(destination) < 30:
		position = destination
		return
	
	time += delta
	var direction: Vector2 = position.direction_to(destination)
	var forward_movement: Vector2 = direction * delta * speed
	var wave_offset: Vector2 = _get_wave_offset(direction)
	position += forward_movement + wave_offset
	
func submit_input(input: String) -> WordStateEnum:
	if input.is_empty():
		submitted_valid_input = ""
		return WordStateEnum.NO_MATCH
	
	if get_text().begins_with(input):
		#Input is valid against word
		submitted_valid_input = input
		highlight_typing(input)
		return WordStateEnum.MATCH
	elif input.begins_with(submitted_valid_input) && !submitted_valid_input.is_empty():
		higlight_error(input)
		return WordStateEnum.PARTIAL_MATCH
	else:
		return WordStateEnum.NO_MATCH

func higlight_error(input: String):
	var highlighted_part: String = submitted_valid_input
	
	var invalid_input: String = input.trim_prefix(submitted_valid_input)
	if input.length() <= unformatted_text.length():
		
		#We typed less than the word
		var valid_last_letter: String = unformatted_text[input.length() - 1]
		var invalid_last_letter: String = invalid_input[invalid_input.length() - 1]
		
		var previous_bad_input: String = unformatted_text.substr(submitted_valid_input.length(), invalid_input.length() -1)
		
		var normal_part: String = unformatted_text.substr(input.length())
		
		label.bbcode = bbcode_template % "[green;b]%s[][red;b]%s[letterswap char=%s]%s[][]%s" % [highlighted_part, previous_bad_input , valid_last_letter, invalid_last_letter, normal_part]
	else:
		var remaining_input: String = unformatted_text.trim_prefix(submitted_valid_input)
		label.bbcode =  bbcode_template % "[green;b]%s[][red;b]%s[]" % [highlighted_part, remaining_input]
		



func highlight_typing(part: String):
	var highlighted_part: String = part.substr(0, part.length() - 1)
	var last_letter: String = part[part.length() - 1]
	var normal_part: String = unformatted_text.substr(part.length())
	label.bbcode = bbcode_template % "[green;b]%s[beat]%s[][]%s" % [highlighted_part, last_letter, normal_part]
	
func _get_wave_offset(direction: Vector2) -> Vector2:
	var x_offset = sin(time * frequency) * amplitude
	var y_offset = sin(time * frequency) * amplitude
	
	var out: Vector2 = Vector2(0,0)
	
	if((direction.x < 0 && direction.y < 0) || (direction.x >= 0 && direction.y >= 0)):
		out.y = y_offset
	else:
		out.x = x_offset
	
	return out
	
