extends BaseWord
class_name MultiValidationWord
var health: int = 0 : get = _get_health, set = _set_health

@export var progress_bar: TextureProgressBar

func _ready() -> void:
	super()
	health = 3
	speed_multiplier = 0.5

func decrement_health() -> void:
	health = health - 1
	reset()
	re_render()
	
func _get_health() -> int:
	return health
	
func _set_health(value: int) -> void:
	health = value
	progress_bar.value = health * 10