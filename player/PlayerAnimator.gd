extends AnimatedSprite2D


func _ready() -> void:
	EventBus.letter_typed.connect(_on_letter_typed)
	EventBus.word_submitted.connect(_on_word_submitted)
	animation_finished.connect(_resume_idle)
	
	
func _resume_idle() -> void:
	play("idle")
	
func _on_letter_typed(text: String) -> void:
	if randi_range(0,1):
		play("typingright")
	else:
		play("typingleft")
		

func _on_word_submitted(text: String) -> void:
	if randi_range(0,1):
		play("typingright")
	else:
		play("typingleft")

	
	
	