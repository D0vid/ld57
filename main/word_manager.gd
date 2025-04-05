extends Node2D

var dictionary: Array[String] = [
								"Mole",
								"Tunnel",
								"Dirt",
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
var words: Array[Word] = []

@export var word_timer: Timer
@export var word_scene: PackedScene
@export var player: Player

func _ready() -> void:
	word_timer.timeout.connect(_on_timeout)
	pass

func _process(delta: float) -> void:
	#timer stuff
	if word_timer.time_left == 0:
		word_timer.start(3)
		
	#move words stuff
	for word in words:
		word.position = word.position.move_toward(player.position, delta * 100)
	
func _on_timeout() -> void:
	spawn_word()
	
func spawn_word() -> void:
	print('spawni spoawno')
	var word_text: String = dictionary.pop_back()
	var word_instance: Word = word_scene.instantiate() as Word
	word_instance.set_text(word_text)
	word_instance.position = get_random_spawn_point()
	get_parent().add_child(word_instance)
	words.push_back(word_instance)

func get_random_spawn_point() -> Vector2:
	var spawn_points: Array[Node] = get_tree().get_nodes_in_group(&"spawn_points")
	var random: int = randi_range(0, 3)
	print('randi %s' % random)
	var spawn_point: Marker2D = spawn_points[random] as Marker2D
	return spawn_point.position
	
