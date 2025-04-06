extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.insight_changed.connect(_on_insight_changed)

func _on_insight_changed(insight: int) -> void:
	text = "%d" % insight