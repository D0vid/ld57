extends AudioStreamPlayer

var loop1 = preload("res://audio_player/audio/loop1.ogg")
var loop2 = preload("res://audio_player/audio/loop2.ogg")
var loop3 = preload("res://audio_player/audio/loop3.ogg")
var bell = preload("res://audio_player/audio/bell.ogg")
var tourbillon = preload("res://audio_player/audio/tourbillon.ogg")
var type1 = preload("res://audio_player/audio/type1.ogg")
var type3 = preload("res://audio_player/audio/type3.ogg")
var type4 = preload("res://audio_player/audio/type4.ogg")
var type5 = preload("res://audio_player/audio/type5.ogg")

@export var fx_player: AudioStreamPlayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pass
	

func play_loop1() -> void:
	loop1.loop = true
	stream = loop1
	play()
	
func play_loop2() -> void:
	loop2.loop = true
	stream = loop2
	play()
	
func play_loop3() -> void:
	loop3.loop = true
	stream = loop3
	play()

func play_bell() -> void:
	fx_player.stream = bell
	fx_player.play()

func play_tourbillon() -> void:
	fx_player.stream = tourbillon
	fx_player.play()
	

func play_type() -> void:
	
	var rand = randi_range(0,4)
	match rand:
		0:
			fx_player.stream = type1
		1:
			fx_player.stream = type3
		2:
			fx_player.stream = type3
		3:
			fx_player.stream = type4
		4:
			fx_player.stream = type5
	
	fx_player.play()


	
