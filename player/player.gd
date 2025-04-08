extends Area2D

class_name Player

@export var sprite: AnimatedSprite2D
@export var typewriter_sprite: Sprite2D

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y - 10, 1)
	tween.tween_property(self, "position:y", position.y + 10, 1)
	tween.set_loops()
	set_color_pink()
	

var health: int  = 100 : get = _get_health, set = _set_health
var insight: int = 0 : get = _get_insight, set = _set_insight

func _get_health() -> int:
	return health

func _set_health(value: int) -> void:
	health = value
	EventBus.health_changed.emit(health)
	if health <= 0:
		EventBus.game_over.emit()

func _get_insight() -> int:
	return insight

func _set_insight(value: int) -> void:
	insight = value
	EventBus.insight_changed.emit(insight)
	if insight >= 1000:
		EventBus.victory.emit()
		
func set_color_red() -> void:
	sprite.material.set("shader_paramater/tint_color", Vector4(0.5, 0.0, 0.13, 1.0))
	typewriter_sprite.material.set("shader_paramater/tint_color", Vector4(0.5, 0.0, 0.13, 1.0))

	
func set_color_pink()-> void:
	sprite.material.set("shader_paramater/tint_color", Vector4(1.0, 0.71, 0.76, 1.0))
	typewriter_sprite.material.set("shader_paramater/tint_color", Vector4(1.0, 0.71, 0.76, 1.0))

func set_color_green() -> void:
	sprite.material.set("shader_paramater/tint_color", Vector4(0.56, 0.93, 0.56, 1.0))
	typewriter_sprite.material.set("shader_paramater/tint_color", Vector4(0.56, 0.93, 0.56, 1.0))

			