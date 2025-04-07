extends AudioStreamPlayer

var loop1 = preload("res://audio_player/audio/loop1.ogg")
var loop2 = preload("res://audio_player/audio/loop2.ogg")
var loop3 = preload("res://audio_player/audio/loop3.ogg")
var bell = preload("res://audio_player/audio/bell.ogg")

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

	
