extends Node2D

class_name WordManager


var words: Array[BaseWord]  = []

@export var word_factory: WordFactory
@export var player: Player
@export var phase_label: Label

enum Phase {
	EASY,
	MEDIUM,
	NIGHTMARE
}

var current_phase: Phase : set = _set_current_phase
var medium_insight_treshold: int = 330
var nightmare_insight_treshold: int = 660
var word_spawner: WordSpawner
var master_speed = 1

func _ready() -> void:
	EventBus.letter_typed.connect(_on_letter_typed)
	EventBus.word_submitted.connect(_on_word_submitted)
	EventBus.insight_changed.connect(_on_insight_changed)
	player.area_entered.connect(_on_area_entered)
	current_phase = Phase.EASY
	word_spawner = WordSpawner.new(word_factory)
	AudioPlayer.play_loop1()
	

func _physics_process(delta: float) -> void:
	var new_word = word_spawner.spawn_word(current_phase, delta)
	if new_word != null:
		get_parent().add_child(new_word)
		words.push_back(new_word)
	
	
	var speed_increase = word_spawner.current_wordlist.get_speed_increase_amount()
	#move words stuff
	for word in words:
		word.move_toward(player.position, delta, master_speed * word_spawner.current_wordlist.speed + speed_increase)

func _set_current_phase(value: Phase) -> void:
	current_phase = value
	phase_label.text = Phase.keys()[current_phase]
	EventBus.phase_changed.emit(value)

func _on_letter_typed(text: String) -> void:
	AudioPlayer.play_type()
	var partial_matching_words: Array[BaseWord] = []
	var found_total_matching_word = false
	
	for i in range(0, words.size()):
		var word: BaseWord = words[i]
		if text.is_empty():
			word.reset()
			word.re_render()
		else:
			var word_matches: BaseWord.WordStateEnum = word.submit_input(str(text))
			if word_matches == BaseWord.WordStateEnum.MATCH:
				found_total_matching_word = true
			elif word_matches == BaseWord.WordStateEnum.PARTIAL_MATCH:
				partial_matching_words.push_back(word)
		
	if found_total_matching_word:
		for partial_matching_word in partial_matching_words:
			partial_matching_word.reset()
			partial_matching_word.re_render()
		
func _on_word_submitted(text: String) -> void:
	AudioPlayer.play_type()

	var mark_as_delete: Array[int] = []
	
	for i: int in range(0, words.size()):
		var word: BaseWord = words[i]
		if word.get_text() == text and not word.inactive: # word matches
			if (word.has_method("decrement_health") and word.health > 1):
				word.decrement_health()
				player.health += 10
				if (word.health == 0):
					mark_as_delete.push_front(i)
					player.insight += 10
				return
			else:
				mark_as_delete.push_front(i)
				player.insight += 10
		else:
			word.reset()
			word.re_render()
	
	for index_to_delete in mark_as_delete:
		var word: BaseWord = words[index_to_delete]
		words.remove_at(index_to_delete)
		word.queue_free()
		
	if mark_as_delete.is_empty() and not text.is_empty():
		# if no words match
		player.health -= 10

func _on_area_entered(body: Node2D) -> void:
	if (body is BaseWord):
		var word: BaseWord = body as BaseWord
		words.erase(word)
		word.queue_free()
		if not word.inactive:
			player.health -= 10

func _on_insight_changed(insight: int) -> void:
	if (current_phase == Phase.EASY and insight >= medium_insight_treshold):
		for word in words:
			word.make_inactive()	
		current_phase = Phase.MEDIUM
		AudioPlayer.play_loop2()
		AudioPlayer.play_bell()
		player.set_color_green()
		EventBus.phase_changed.emit(current_phase)
	if (current_phase == Phase.MEDIUM and insight >= nightmare_insight_treshold):
		for word in words:
			word.make_inactive()
		current_phase = Phase.NIGHTMARE
		AudioPlayer.play_loop3()
		AudioPlayer.play_bell()
		player.set_color_red()
		EventBus.phase_changed.emit(current_phase)
