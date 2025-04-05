extends Label

var template: String = "Insight: %s"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.insight_changed.connect(_on_insight_changed)

func _on_insight_changed(insight: int) -> void:
	text = template % insight