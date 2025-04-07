extends Node2D

class_name WordManager

var word_list_easy: WordList = WordList.new([
	WordData.new("butterfly", WordData.Type.NORMAL),
	WordData.new("meadow", WordData.Type.NORMAL),
	WordData.new("sunlight", WordData.Type.NORMAL),
	WordData.new("lullaby", WordData.Type.NORMAL),
	WordData.new("dream", WordData.Type.BLINKING),
	WordData.new("cloud", WordData.Type.NORMAL),
	WordData.new("rainbow", WordData.Type.NORMAL),
	WordData.new("forest", WordData.Type.NORMAL),
	WordData.new("star", WordData.Type.NORMAL),
	WordData.new("whispers", WordData.Type.NORMAL),
	WordData.new("soft", WordData.Type.BLINKING),
	WordData.new("breeze", WordData.Type.BLINKING),
	WordData.new("glimmer", WordData.Type.BLINKING),
	WordData.new("petal", WordData.Type.BLINKING),
	WordData.new("echo", WordData.Type.MULTI_VALIDATION),
	WordData.new("dew", WordData.Type.NORMAL),
	WordData.new("fawn", WordData.Type.NORMAL),
	WordData.new("moonlight", WordData.Type.NORMAL),
	WordData.new("bloom", WordData.Type.NORMAL),
	WordData.new("sleep", WordData.Type.BLINKING),
	WordData.new("wind", WordData.Type.NORMAL),
	WordData.new("laughter", WordData.Type.NORMAL),
	WordData.new("crystal", WordData.Type.NORMAL),
	WordData.new("lantern", WordData.Type.NORMAL),
	WordData.new("drift", WordData.Type.BLINKING),
	WordData.new("heart", WordData.Type.NORMAL),
	WordData.new("mist", WordData.Type.BLINKING),
	WordData.new("twilight", WordData.Type.BLINKING),
	WordData.new("wander", WordData.Type.NORMAL),
	WordData.new("reflection", WordData.Type.BLINKING),
	WordData.new("whimsy", WordData.Type.NORMAL),
	WordData.new("glow", WordData.Type.BLINKING),
	WordData.new("???", WordData.Type.MULTI_VALIDATION),
])

var word_list_medium: WordList = WordList.new([
	WordData.new("hollow", WordData.Type.NORMAL),
	WordData.new("veil", WordData.Type.NORMAL),
	WordData.new("silk", WordData.Type.BLINKING),
	WordData.new("murmur", WordData.Type.NORMAL),
	WordData.new("unseen", WordData.Type.BLINKING),
	WordData.new("murk", WordData.Type.NORMAL),
	WordData.new("Ucxudhrutl", WordData.Type.NORMAL),
	WordData.new("HoLLoWeD", WordData.Type.NORMAL),
	WordData.new("forgotten", WordData.Type.BLINKING),
	WordData.new("unearthed", WordData.Type.NORMAL),
	WordData.new("VEilEd", WordData.Type.NORMAL),
	WordData.new("starlight", WordData.Type.BLINKING),
	WordData.new("fOg", WordData.Type.NORMAL),
	WordData.new("Yovaaztosh", WordData.Type.NORMAL),
	WordData.new("SHIVER", WordData.Type.BLINKING),
	WordData.new("abyss", WordData.Type.NORMAL),
	WordData.new("eerie", WordData.Type.NORMAL),
	WordData.new("fathom", WordData.Type.NORMAL),
	WordData.new("nightshade", WordData.Type.BLINKING),
	WordData.new("oc'thaatloh", WordData.Type.NORMAL),
	WordData.new("pulse", WordData.Type.NORMAL),
	WordData.new("EnIgMa", WordData.Type.NORMAL),
	WordData.new("wraith", WordData.Type.BLINKING),
	WordData.new("yid'ognnig", WordData.Type.NORMAL),
	WordData.new("ObScUrE", WordData.Type.NORMAL),
	WordData.new("blackened", WordData.Type.NORMAL),
	WordData.new("cxothalbh", WordData.Type.BLINKING),
	WordData.new("unravel", WordData.Type.NORMAL),
	WordData.new("cryptic", WordData.Type.NORMAL),
	WordData.new("unholy", WordData.Type.BLINKING),
	WordData.new("yoc'thaggiss", WordData.Type.NORMAL),
	WordData.new("dread", WordData.Type.NORMAL),
	WordData.new("ABOMINATION", WordData.Type.MULTI_VALIDATION)
])

var word_list_nightmare: WordList = WordList.new([
	WordData.new("help me", WordData.Type.MULTI_VALIDATION, 2),
	WordData.new("grief", WordData.Type.BLINKING),
	WordData.new("searing", WordData.Type.BLINKING),
	WordData.new("mournful", WordData.Type.BLINKING),
	WordData.new("hElp mE", WordData.Type.NORMAL),
	WordData.new("requiem", WordData.Type.BLINKING),
	WordData.new("Zughrotl'Thuth", WordData.Type.NORMAL),
	WordData.new("shattered", WordData.Type.BLINKING),
	WordData.new("HELP ME", WordData.Type.NORMAL),
	WordData.new("phantom", WordData.Type.BLINKING),
	WordData.new("blight", WordData.Type.BLINKING),
	WordData.new("Aic'Thygh'Vhis", WordData.Type.NORMAL),
	WordData.new("ruin", WordData.Type.BLINKING),
	WordData.new("nightmarish", WordData.Type.BLINKING),
	WordData.new("malevolent", WordData.Type.BLINKING),
	WordData.new("rot", WordData.Type.BLINKING),
	WordData.new("help...", WordData.Type.NORMAL),
	WordData.new("Aighraadhrux", WordData.Type.BLINKING),
	WordData.new("abyssal", WordData.Type.BLINKING),
	WordData.new("sorrows", WordData.Type.BLINKING),
	WordData.new("help me ... please", WordData.Type.NORMAL),
	WordData.new("writhing", WordData.Type.BLINKING),
	WordData.new("madness", WordData.Type.BLINKING),
	WordData.new("cursed", WordData.Type.BLINKING),
	WordData.new("Ctuignn'Gnu", WordData.Type.NORMAL),
	WordData.new("eldritch", WordData.Type.BLINKING),
	WordData.new("unseen", WordData.Type.BLINKING),
	WordData.new("void", WordData.Type.BLINKING),
	WordData.new("tainted", WordData.Type.NORMAL),
	WordData.new("disembodied", WordData.Type.BLINKING),
	WordData.new("frenzied", WordData.Type.BLINKING),
	WordData.new("unfathomable", WordData.Type.BLINKING),
	WordData.new("abominable", WordData.Type.BLINKING),
	WordData.new("Laucthaar'Xa", WordData.Type.NORMAL),
	WordData.new("foulness", WordData.Type.BLINKING),
	WordData.new("eldritch", WordData.Type.BLINKING),
	WordData.new("netherworld", WordData.Type.BLINKING),
	WordData.new("horrid", WordData.Type.BLINKING),
	WordData.new("devouring", WordData.Type.BLINKING),
	WordData.new("Yokaazh'Vhotl", WordData.Type.MULTI_VALIDATION, 2),
])

var current_word_list: WordList = word_list_easy

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
var timer_difficulties: Array[float] = [1.5, 1.4, 1.3]
var speed_difficulties: Array[int] = [50, 55, 60]
var medium_insight_treshold: int = 330
var nightmare_insight_treshold: int = 660

func _ready() -> void:
	word_timer.timeout.connect(_on_timeout)
	EventBus.letter_typed.connect(_on_letter_typed)
	EventBus.word_submitted.connect(_on_word_submitted)
	EventBus.insight_changed.connect(_on_insight_changed)
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
	if (current_word_list.list.size() > 0):
		spawn_word()
	
func spawn_word() -> void:
	var word_data: WordData = current_word_list.list.pop_front()
	var word_text: String = word_data.text
	current_word_list.list.push_back(word_data)
	
	var word_instance: BaseWord
	
	match word_data.type:
		WordData.Type.NORMAL:
			word_instance = word_factory.create_normal_word(word_text, "wave")
		WordData.Type.BLINKING: 
			word_instance = word_factory.create_blinking_word(word_text, "wave")
		WordData.Type.MULTI_VALIDATION: 
			word_instance = word_factory.create_multivalidation_word(word_text, "wave", word_data.validations)

	word_instance.position = get_random_spawn_point()
	get_parent().add_child(word_instance)
	words.push_back(word_instance)

func get_random_spawn_point() -> Vector2:
	var max_x = DisplayServer.screen_get_size().x
	var max_y = DisplayServer.screen_get_size().y
	var random_side: int = randi_range(0, 1)
	var random_y: int = randi_range(0, max_y)
	
	match random_side:
		0: return Vector2(max_x, random_y) # right
		1: return Vector2(0, random_y) # left
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
		current_word_list = word_list_medium
		EventBus.phase_changed.emit(current_phase)
	if (current_phase == Phase.MEDIUM and insight >= nightmare_insight_treshold):
		for word in words:
			word.make_inactive()
		current_phase = Phase.NIGHTMARE
		current_word_list = word_list_nightmare
		EventBus.phase_changed.emit(current_phase)
