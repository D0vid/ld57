extends Node

var total_counter: int = 0
var combo_counter: int = 0 : set = _set_combo_counter
var max_combo: int = 0

func _set_combo_counter(value: int) -> void:
	combo_counter = value
	if combo_counter > max_combo:
		max_combo = combo_counter
	
func reset() -> void:
	total_counter = 0
	combo_counter = 0
	max_combo = 0