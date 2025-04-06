extends RefCounted

class_name WordData

enum Type {
	NORMAL,
	BLINKING,
	MULTI_VALIDATION
}

var text: String
var type: Type
var speed: int

func _init(_text: String, _type: Type, _speed: int):
	text = _text;
	type = _type;
	speed = _speed;