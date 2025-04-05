extends Area2D

class_name Word

@export var label: RicherTextLabel

# Track progress
var time: float = 0.0
var frequency: int = 5     # How quickly the wave oscillates
var amplitude: float = 0.3     # How far the wave deviates

var unformatted_text: String
var bbcode_effect: String

func _ready() -> void:
	add_to_group(&"words")
func _process(_delta: float) -> void:
	pass
	
func set_text(text: String, bbcode: String) -> void:
	unformatted_text = text
	bbcode_effect = bbcode
	label.size = Vector2(label.size.x, text.length() * 10)
	_set_formatted_text(text, bbcode)

func get_text() -> String:
	return unformatted_text
	
func move_toward(destination: Vector2, delta: float, speed: int):
	if position.distance_to(destination) < 30:
		position = destination
		return
	
	time += delta
	var direction: Vector2 = position.direction_to(destination)
	var forward_movement: Vector2 = direction * delta * speed
	var wave_offset: Vector2 = _get_wave_offset(direction)
	position += forward_movement + wave_offset

func highlight_typing(part: String):
	var highlighted_part    = part.substr(0, part.length()-1)
	
	var last_letter: String = part[part.length() - 1]
	var normal_part         = unformatted_text.substr(part.length())
	_set_formatted_text("[green;b]%s[beat]%s[][]%s" % [highlighted_part, last_letter, normal_part], bbcode_effect)	
	
	
func _set_formatted_text(text: String, bbcode: String) -> void:
	print(bbcode % text)
	label.bbcode = bbcode % text

func _get_wave_offset(direction: Vector2) -> Vector2:
	var x_offset = sin(time * frequency) * amplitude
	var y_offset = sin(time * frequency) * amplitude
	
	var out: Vector2 = Vector2(0,0)
	
	if((direction.x < 0 && direction.y < 0) || (direction.x >= 0 && direction.y >= 0)):
		out.y = y_offset
	else:
		out.x = x_offset
	
	return out
	
