extends Label

func _ready() -> void:
	EventBus.insight_changed.connect(_on_insight_changed)

func _on_insight_changed(insight: int) -> void:
	text = str(insight)