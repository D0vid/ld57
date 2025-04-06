extends Area2D

class_name BaseWord

enum WordStateEnum {
	MATCH,
	PARTIAL_MATCH,
	NO_MATCH
}


@export var label: RicherTextLabel
@export var collision_shape: CollisionShape2D

var unformatted_text: String
var display_text: String

var bbcode_template: String

var submitted_valid_input: String

var bezier_control

func _ready() -> void:
	if randi_range(0,1) == 0:
		bezier_control = 1000
	else:
		bezier_control = -1000
	
func _process(_delta: float) -> void:
	pass

func set_text(text: String) -> void:
	unformatted_text = text
	collision_shape.shape.size = Vector2(18 * text.length(), 50)

func set_bbcode_template(bbcode_template: String):
	self.bbcode_template = bbcode_template

func re_render() -> void:
	label.bbcode = bbcode_template % unformatted_text

func reset() -> void:
	submitted_valid_input = ""


func get_text() -> String:
	return unformatted_text

func _move_toward_bezier(destination: Vector2, delta: float, speed: int, control_distance: float) -> void:
	# Calculate the direction vector from the initial position to the destination (center)
	var direction_to_center = (destination - position).normalized()

	# Calculate the perpendicular vector
	var perpendicular_vector = Vector2(-direction_to_center.y, direction_to_center.x)

	# Calculate the control point position
	var control_point = destination + perpendicular_vector * control_distance

	# Calculate the current parameter t based on the distance to the destination
	var distance_to_destination = position.distance_to(destination)
	var t = 1.0 - (distance_to_destination / position.distance_to(control_point))
	t = clamp(t, 0.0, 1.0)

	# Calculate the position on the Bezier curve using the parametric equations
	var bezier_position = Vector2(
							  (1.0 - t) * (1.0 - t) * position.x + 2.0 * (1.0 - t) * t * control_point.x + t * t * destination.x,
							  (1.0 - t) * (1.0 - t) * position.y + 2.0 * (1.0 - t) * t * control_point.y + t * t * destination.y
						  )

	# Calculate the direction from the current position to the Bezier position
	var direction = (bezier_position - position).normalized()

	# Calculate the forward movement
	var forward_movement = direction * delta * speed

	# Update the position
	position += forward_movement	

func move_toward(destination: Vector2, delta: float, speed: int) -> void:
	_move_toward_bezier(destination, delta, speed, bezier_control)
	
func _move_toward_straighto(destination: Vector2, delta: float, speed: int) -> void:
	var direction: Vector2 = position.direction_to(destination)
	var forward_movement: Vector2 = direction * delta * speed
	position += forward_movement 

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
	print('highlighted_part: %s' % highlighted_part)

	var invalid_input: String = input.trim_prefix(submitted_valid_input)
	print('invalid_input: %s' % invalid_input)
	if input.length() <= unformatted_text.length():

		#We typed less than the word
		var valid_last_letter: String = unformatted_text[input.length() - 1]
		print('valid_last_letter: %s' % valid_last_letter)
		var invalid_last_letter: String = invalid_input[invalid_input.length() - 1]
		print('invalid_last_letter: %s' % invalid_last_letter)

		var previous_bad_input: String = unformatted_text.substr(submitted_valid_input.length(), invalid_input.length() -1)
		print('previous_bad_input: %s' % previous_bad_input)

		var normal_part: String = unformatted_text.substr(input.length())
		print('normal_part: %s' % normal_part)

		label.bbcode = bbcode_template % "[green;b]%s[][red;b]%s[letterswap char=%s]%s[][]%s" % [highlighted_part, previous_bad_input , valid_last_letter, invalid_last_letter, normal_part]
	else:
		var remaining_input: String = unformatted_text.trim_prefix(submitted_valid_input)
		if remaining_input.is_empty():
			label.bbcode =  bbcode_template % "[red;b]%s[]" % highlighted_part
		else:
			label.bbcode =  bbcode_template % "[green;b]%s[red;b]%s[]" % [highlighted_part, remaining_input]

		
func highlight_typing(part: String):
	var highlighted_part: String = part.substr(0, part.length() - 1)
	var last_letter: String = part[part.length() - 1]
	var normal_part: String = unformatted_text.substr(part.length())
	label.bbcode = bbcode_template % "[green;b]%s[beat]%s[][]%s" % [highlighted_part, last_letter, normal_part]
