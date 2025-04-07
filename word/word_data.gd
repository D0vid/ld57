extends RefCounted

class_name WordData

enum Type {
	NORMAL,
	BLINKING,
	MULTI_VALIDATION
}

var text: String
var type: Type
var validations: int

func _init(_text: String, _type: Type, _validations = 0):
	text = _text;
	type = _type;
	validations = _validations
	