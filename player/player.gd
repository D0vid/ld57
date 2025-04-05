extends Area2D

class_name Player

var health: int  = 100 : get = _get_health, set = _set_health
var insight: int = 0 : get = _get_insight, set = _set_insight

func _get_health() -> int:
	return health

func _set_health(value: int) -> void:
	health = value
	EventBus.health_changed.emit(health)

func _get_insight() -> int:
	return insight

func _set_insight(value: int) -> void:
	insight = value
	EventBus.insight_changed.emit(insight)