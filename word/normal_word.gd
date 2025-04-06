extends BaseWord

class_name NormalWord

# Track progress
var time: float = 0.0
var frequency: int = 5     # How quickly the wave oscillates
var amplitude: float = 0.3     # How far the wave deviates

func move_toward(destination: Vector2, delta: float, speed: int) -> void:

	if position.distance_to(destination) < 30:
		position = destination
		return

	time += delta
	var direction: Vector2 = position.direction_to(destination)
	var forward_movement: Vector2 = direction * delta * speed
	var wave_offset: Vector2 = _get_wave_offset(direction)
	position += forward_movement + wave_offset

func _get_wave_offset(direction: Vector2) -> Vector2:
	var x_offset = sin(time * frequency) * amplitude
	var y_offset = sin(time * frequency) * amplitude

	var out: Vector2 = Vector2(0,0)

	if((direction.x < 0 && direction.y < 0) || (direction.x >= 0 && direction.y >= 0)):
		out.y = y_offset
	else:
		out.x = x_offset

	return out
	
	