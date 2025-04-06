extends Label

func _ready() -> void:
	EventBus.health_changed.connect(_on_health_changed)

func _on_health_changed(health: int) -> void:
	text = str(health)