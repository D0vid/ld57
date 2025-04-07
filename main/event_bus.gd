extends Node

signal letter_typed(text: String)

signal word_submitted(text: String)
	
signal health_changed(health: int)
	
signal insight_changed(insight: int)
	
signal start_game_clicked() 
	
signal phase_changed(phase: WordManager.Phase)
