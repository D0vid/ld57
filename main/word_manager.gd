extends Node2D

var dictionary: Array[String] = [
								"Mole",
								"Tunnel",
								"Dirt",
								"Earth",
								"Earth",
								"Underground",
								"Dig",
								"Burrow",
								"Core",
								"Journey",
								"Darkness",
								"Soil",
								"Rock",
								"Path",
								"Cavern",
								"Adventure",
								"Depth",
								"Roots",
								"Excavation",
								"Ground",
								"Discovery"
								]
var words: Array[BaseWord]  = []

@export var word_timer: Timer
@export var normal_word_scene: PackedScene
@export var blinking_word_scene: PackedScene

@export var player: Player

func _ready() -> void:
	word_timer.timeout.connect(_on_timeout)
	EventBus.letter_typed.connect(_on_letter_typed)
	EventBus.word_submitted.connect(_on_word_submitted)
	player.area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	#timer stuff
	if word_timer.time_left == 0:
		word_timer.start(3)
		
	#move words stuff
	for word in words:
		word.move_toward(player.position, delta, 30)
		
	
func _on_timeout() -> void:
	spawn_word()
	
func spawn_word() -> void:
	var word_text: String = dictionary.pop_back()
	dictionary.push_front(word_text)
	var word_instance: BaseWord = blinking_word_scene.instantiate() as BaseWord
	word_instance.set_text(word_text)
	word_instance.set_bbcode_template("[wave]%s[]")
	word_instance.re_render()
	word_instance.position = get_random_spawn_point()
	get_parent().add_child(word_instance)
	words.push_back(word_instance)

func get_random_spawn_point() -> Vector2:
	var spawn_points: Array[Node] = get_tree().get_nodes_in_group(&"spawn_points")
	var random: int = randi_range(0, 3)
	var spawn_point: Marker2D = spawn_points[random] as Marker2D
	return spawn_point.position
	
func _on_letter_typed(text: String) -> void:
	var partial_matching_words: Array[BaseWord] = []
	var found_total_matching_word: bool           = false
	
	for i in range(0, words.size()):
		var word: BaseWord = words[i]
		if text.is_empty():
			word.reset()
			word.re_render()
		else:
			var word_matches: BaseWord.WordStateEnum = word.submit_input(text)
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
			mark_as_delete.push_front(i)
			player.insight += 10
		else:
			word.reset()
			word.re_render()
		
	
	for index_to_delete in mark_as_delete:
		var word: BaseWord = words[index_to_delete]
		words.remove_at(index_to_delete)
		word.queue_free()
		
	if mark_as_delete.is_empty():
		# if no words match
		player.health -= 10

func _on_area_entered(body: Node2D) -> void:
	print("black pink")
	if (body is BaseWord):
		var word: BaseWord = body as BaseWord
		words.erase(word)
		word.queue_free()
		player.health -= 10
