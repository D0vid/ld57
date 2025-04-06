extends Node2D

var word_list: WordList = WordList.new([
#	WordData.new("test", WordData.Type.NORMAL, 50),
	WordData.new("test1", WordData.Type.NORMAL, 50),
#	WordData.new("test3", WordData.Type.NORMAL, 50),
])
var words: Array[BaseWord]  = []

@export var word_timer: Timer
@export var word_factory: WordFactory
@export var player: Player
@export var phase_label: Label

enum Phase {
	EASY,
	MEDIUM,
	NIGHTMARE
}

var current_phase: Phase : set = _set_current_phase
var timer_difficulties: Array[float] = [2, 1.75, 1.5]
var speed_difficulties: Array[int] = [50, 75, 100]
var medium_insight_treshold: int = 100
var nightmare_insight_treshold: int = 200

func _ready() -> void:
	print(word_list.list.size())
	word_timer.timeout.connect(_on_timeout)
	EventBus.letter_typed.connect(_on_letter_typed)
	EventBus.word_submitted.connect(_on_word_submitted)
	player.area_entered.connect(_on_area_entered)
	current_phase = Phase.EASY

func _physics_process(delta: float) -> void:
	#timer stuff
	if word_timer.time_left == 0:
		word_timer.start(timer_difficulties[current_phase])
		
	#move words stuff
	for word in words:
		word.move_toward(player.position, delta, speed_difficulties[current_phase])

func _set_current_phase(value: Phase) -> void:
	current_phase = value
	phase_label.text = Phase.keys()[current_phase]
	
func _on_timeout() -> void:
	spawn_word()
	
func spawn_word() -> void:
	var word_data: WordData = word_list.list.pop_back()
	var word_text: String = word_data.text
	word_list.list.push_front(word_data)
	
	var word_instance: BaseWord
	
	match word_data.type:
		WordData.Type.NORMAL:
			word_instance = word_factory.create_normal_word(word_text, "wave")
		WordData.Type.BLINKING: 
			word_instance = word_factory.create_blinking_word(word_text, "wave")
		WordData.Type.MULTI_VALIDATION: 
			word_instance = word_factory.create_multivalidation_word(word_text, "wave")

	word_instance.position = get_random_spawn_point()
	get_parent().add_child(word_instance)
	words.push_back(word_instance)

func get_random_spawn_point() -> Vector2:
	var max_x = DisplayServer.screen_get_size().x
	var max_y = DisplayServer.screen_get_size().y
	var random_side: int = randi_range(0, 3)
	var random_x: int = randi_range(0, max_x)
	var random_y: int = randi_range(0, max_y)
	
	match random_side:
		0: return Vector2(random_x, -200) # up
		1: return Vector2(max_x + 200, random_y) # right
		2: return Vector2(random_x, max_y + 200) # down
		3: return Vector2(-200, random_y) # left
		_: return Vector2.ZERO
	
func _on_letter_typed(text: String) -> void:
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
	
	var mark_as_delete: Array[int] = []
	
	for i: int in range(0, words.size()):
		var word: BaseWord = words[i]
		if word.get_text() == text: # word matches
			if (word.has_method("decrement_health") and word.health > 1):
				word.decrement_health()
				if (word.health == 0):
					mark_as_delete.push_front(i)
					player.insight += 10
			else:
				mark_as_delete.push_front(i)
				player.insight += 10
		else:
			word.reset()
			word.re_render()
	if (current_phase == Phase.EASY and player.insight > medium_insight_treshold):
		current_phase = Phase.MEDIUM
	if (current_phase == Phase.MEDIUM and player.insight > nightmare_insight_treshold):
		current_phase = Phase.NIGHTMARE
	
	for index_to_delete in mark_as_delete:
		var word: BaseWord = words[index_to_delete]
		words.remove_at(index_to_delete)
		word.queue_free()
		
	if mark_as_delete.is_empty():
		# if no words match
		player.health -= 10

func _on_area_entered(body: Node2D) -> void:
	if (body is BaseWord):
		var word: BaseWord = body as BaseWord
		words.erase(word)
		word.queue_free()
		player.health -= 10
