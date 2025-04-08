extends Area2D

class_name Player

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y - 10, 1)
	tween.tween_property(self, "position:y", position.y + 10, 1)
	tween.set_loops()
	
var health: int  = 100 : get = _get_health, set = _set_health
var insight: int = 0 : get = _get_insight, set = _set_insight

func _get_health() -> int:
	return health

func _set_health(value: int) -> void:
	if value < health:
		Stats.combo_counter = 0
	health = value
	EventBus.health_changed.emit(health)
	if health <= 0:
		EventBus.game_over.emit()

func _get_insight() -> int:
	return insight

func _set_insight(value: int) -> void:
	Stats.total_counter += 1
	Stats.combo_counter += 1
	insight = value
	EventBus.insight_changed.emit(insight)
	if insight >= 10:
		EventBus.victory.emit()