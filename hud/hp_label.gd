extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.health_changed.connect(_on_health_changed)

func _on_health_changed(health: int) -> void:
	text = "%d" % health